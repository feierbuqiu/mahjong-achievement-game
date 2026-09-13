// Original-coordinate strategy adapter. Frozen rules/index/reader are reused.
// Include the index first so its own baseline-main renaming cannot affect ours.
#include "global_index.hpp"
#define main frozen_oracle_query_entry_for_physical_strategy
#include "verify_oracles.cpp"
#undef main

namespace physical_strategy {
using namespace oq;
const char* SCHEMA="MAHJONG_PHYSICAL_STRATEGY_V1";
struct Advice {std::string json,status;};
std::string tile_name(int i){
    static const char* suits[]={"m","p","s"};
    static const char* honors[]={"East","South","West","North","White","Green","Red"};
    return i<27?std::to_string(i%9+1)+suits[i/9]:honors[i-27];
}
std::string tile_code(int i){
    static const char* suits[]={"m","p","s"};
    static const char* honors[]={"East","South","West","North","White","Green","Red"};
    return i<27?std::to_string(i%9+1)+suits[i/9]:honors[i-27];
}
State parse_raw(const std::string&s){
    require(s.size()==34&&s.find_first_not_of("01234")==std::string::npos,"input must contain exactly 34 digits 0..4");
    const State raw=::parse(s);require(::repr(raw)==s,"raw parse changed input coordinates");return raw;
}
void verify_one_addition(const std::string&raw,const std::string&child,int i){
    require(i>=0&&i<34&&raw.size()==34&&child.size()==34&&raw[i]<'4',"illegal physical move");
    for(int k=0;k<34;++k)require(int(child[k])-int(raw[k])==(k==i?1:0),"physical child is not the claimed one-tile addition");
}
std::string evidence(const Lookup&r){
    require(r.known,"cannot emit unknown table evidence");std::ostringstream j;
    j<<"{\"state\":"<<quote(r.state)<<",\"outcome\":\""<<(r.p?"P":"N")<<"\",\"n\":"<<r.n<<",\"h\":"<<r.h<<",\"rank\":"<<r.rank
     <<",\"bucket\":"<<quote(r.bucket)<<",\"layer_metadata_complete\":true,\"queried_payload_integrity_verified\":true}";return j.str();
}
void move_fields(std::ostringstream&j,const std::string&raw,const std::string&child,int i){
    verify_one_addition(raw,child,i);
    j<<",\"original_tile_index_zero_based\":"<<i<<",\"tile_code\":"<<quote(tile_code(i))<<",\"tile_name\":"<<quote(tile_name(i))
     <<",\"physical_child\":"<<quote(child)<<",\"canonical_child\":"<<quote(::repr(::canon(::parse(child))))
     <<",\"physical_one_tile_addition_verified\":true";
}
Advice advise(Database&db,const std::string&input,size_t request_index){
    db.check_budget();const State raw=parse_raw(input);const std::string canonical=::repr(::canon(raw));
    std::ostringstream j;j<<"{\"kind\":\"strategy\",\"schema\":"<<quote(SCHEMA)<<",\"request_index\":"<<request_index
      <<",\"coordinate_system\":\"original_input\",\"input_state\":"<<quote(input)<<",\"canonical_parent\":"<<quote(canonical);
    if(::terminal(raw)){
        j<<",\"status\":\"GAME_ALREADY_FINISHED\",\"game_over\":true,\"reason\":\"input_already_contains_a_winning_14_tile_subset\",\"database_lookup\":false}";
        return {j.str(),"GAME_ALREADY_FINISHED"};
    }
    struct Candidate{int tile;std::string text;State state;};std::vector<Candidate> children;children.reserve(34);
    for(int i=0;i<34;++i)if(input[i]<'4'){
        std::string child=input;++child[i];const State state=::parse(child);verify_one_addition(input,child,i);
        if(::terminal(state)){
            j<<",\"status\":\"IMMEDIATE_WIN\",\"outcome\":\"N\",\"outcome_basis\":\"original_game_immediate_completion\",\"database_lookup\":false";
            move_fields(j,input,child,i);j<<",\"child_terminal_verified\":true}";return {j.str(),"IMMEDIATE_WIN"};
        }
        children.push_back({i,std::move(child),state});
    }
    require(::safe(raw),"nonterminal non-SAFE input has no immediate winning move; rules disagree");
    const auto parent=db.lookup(raw);
    if(!parent.known){j<<",\"status\":\"UNKNOWN\",\"reason\":"<<quote(parent.reason)<<'}';return {j.str(),"UNKNOWN"};}
    require(parent.state==canonical,"reader canonical parent mismatch");
    j<<",\"outcome\":\""<<(parent.p?"P":"N")<<"\",\"outcome_basis\":\"verified_SAFE_table\",\"parent_evidence\":"<<evidence(parent);
    if(parent.p){
        j<<",\"status\":\"FORCED_LOSS\",\"has_forced_winning_move\":false,\"message\":\"The player to move loses under optimal play; no move guarantees a win.\",\"all_child_values_rechecked\":false}";
        return {j.str(),"FORCED_LOSS"};
    }
    size_t checked=0;
    for(const auto&c:children){
        db.check_budget();if(!::safe(c.state))continue;
        const auto child=db.lookup(c.state);++checked;
        if(!child.known){j<<",\"status\":\"UNKNOWN\",\"reason\":\"successor_layer_incomplete\"}";return {j.str(),"UNKNOWN"};}
        if(!child.p)continue;
        require(child.state==::repr(::canon(c.state)),"P witness canonical child mismatch");
        j<<",\"status\":\"WINNING_SAFE_MOVE\",\"has_forced_winning_move\":true";move_fields(j,input,c.text,c.tile);
        j<<",\"physical_child_SAFE_verified\":true,\"p_witness\":"<<evidence(child)<<",\"SAFE_candidates_checked\":"<<checked<<'}';
        return {j.str(),"WINNING_SAFE_MOVE"};
    }
    throw std::runtime_error("N table state has no physical SAFE P successor: "+input);
}
}

int main(int argc,char**argv){try{
    using namespace physical_strategy;std::vector<fs::path>dirs;std::vector<std::string>states;fs::path output;double seconds=120;
    for(int i=1;i<argc;++i){const std::string a=argv[i];
        if(a=="--help"){std::cout<<"strategy_physical --data DIR [--data DIR] --state 34digits [--state 34digits] [--output FILE] [--seconds 120]\nCoordinates: 1m..9m,1p..9p,1s..9s,East/South/West/North/White/Green/Red; indices 0..33.\n";return 0;}
        require(i+1<argc,"missing value for "+a);const std::string v=argv[++i];
        if(a=="--data")dirs.push_back(fs::u8path(v));else if(a=="--state")states.push_back(v);else if(a=="--output")output=fs::u8path(v);else if(a=="--seconds")seconds=std::stod(v);else throw std::runtime_error("unknown option "+a);
    }
    require(!dirs.empty()&&!states.empty(),"provide --data and at least one --state");require(seconds>0,"seconds must be positive");
    // repr()/rule tables require Index initialization; only validate bytes here.
    for(const auto&s:states)require(s.size()==34&&s.find_first_not_of("01234")==std::string::npos,"input must contain exactly 34 digits 0..4");
    const auto began=Clock::now();retro::Index index;Database db(index,dirs,seconds);std::ofstream f;
    if(!output.empty()){if(!output.parent_path().empty())fs::create_directories(output.parent_path());f.open(output,std::ios::binary);require(bool(f),"cannot open strategy output");}
    auto emit=[&](const std::string&s,bool console){if(f)f<<s<<'\n';if(console)std::cout<<s<<std::endl;};
    std::map<std::string,size_t> counts;size_t unknown=0;
    for(size_t i=0;i<states.size();++i){
        Advice result;
        try{result=advise(db,states[i],i);}catch(const Missing&e){result.status="UNKNOWN";result.json="{\"kind\":\"strategy\",\"request_index\":"+std::to_string(i)+",\"input_state\":"+quote(states[i])+",\"status\":\"UNKNOWN\",\"reason\":"+quote(e.what())+"}";}
        ++counts[result.status];unknown+=result.status=="UNKNOWN";emit(result.json,!f);
    }
    std::ostringstream sum;sum<<"{\"kind\":\"summary\",\"schema\":"<<quote(SCHEMA)<<",\"status\":\""<<(unknown?"UNKNOWN":"PASS")<<"\",\"index_fingerprint\":"<<quote(hex(index.fingerprint))
       <<",\"requests\":"<<states.size()<<",\"unknown_items\":"<<unknown<<",\"verified_payload_bytes\":"<<db.verified_payload_bytes<<",\"status_counts\":{";
    bool comma=false;for(const auto&kv:counts){sum<<(comma?",":"")<<quote(kv.first)<<':'<<kv.second;comma=true;}
    sum<<"},\"seconds\":"<<std::chrono::duration<double>(Clock::now()-began).count()<<'}';emit(sum.str(),true);return unknown?2:0;
}catch(const std::exception&e){std::cerr<<"{\"status\":\"FAIL\",\"reason\":"<<oq::quote(e.what())<<"}"<<std::endl;return 1;}}
