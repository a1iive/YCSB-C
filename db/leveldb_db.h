#ifndef YCSB_C_LEVELDB_DB_H
#define YCSB_C_LEVELDB_DB_H

#include "core/db.h"
#include <iostream>
#include <string>
#include "core/properties.h"
#include "core/core_workload.h"

#include <leveldb/db.h>


using std::cout;
using std::endl;

namespace ycsbc {
    class LevelDB : public DB{
    public :
        LevelDB(const char *dbfilename, utils::Properties &props);
        int Read(const std::string &table, const std::string &key,
                 const std::vector<std::string> *fields,
                 std::vector<KVPair> &result, int num);

        int Scan(const std::string &table, const std::string &key, const std::string &max_key,
                 int len, const std::vector<std::string> *fields,
                 std::vector<std::vector<KVPair>> &result, int num);

        int Insert(const std::string &table, const std::string &key,
                   std::vector<KVPair> &values, int num);

        int Update(const std::string &table, const std::string &key,
                   std::vector<KVPair> &values, int num);

        int Delete(const std::string &table, const std::string &key, int num);

        void PrintStats();

        ~LevelDB();

    private:
        leveldb::DB *db_;
        unsigned noResult;
        bool write_sync_;

        void SetOptions(leveldb::Options *options, utils::Properties &props);
        void SerializeValues(std::vector<KVPair> &kvs, std::string &value);
        void DeSerializeValues(std::string &value, std::vector<KVPair> &kvs);

    };
}


#endif //YCSB_C_LEVELDB_DB_H