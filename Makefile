
CC=g++
CXXFLAGS= -std=c++11 -g -Wall -I./
LDFLAGS= -lpthread 

LIB_SOURCES= \
		core/core_workload.cc  \
		db/db_factory.cc   \
		db/hashtable_db.cc  \
		lib/histogram.cc \

##HWDB
HWDB_FLAGS= -I/home/hhs/hwdb/HW_KVSTORE/include
HWDB_SOURCES= db/hwdb_db.cc
HWDB_LIBRARY= /home/hhs/hwdb/HW_KVSTORE/libhwdb.a
HWDB_DEFS= -DYCSB_HWDB
HWDB_OBJECTS=$(HWDB_SOURCES:.cc=.o)
##

##rocksdb
ROCKSDB_FLAGS= -I/home/hhs/hwdb/rocksdb/include
ROCKSDB_SOURCES= db/rocksdb_db.cc
ROCKSDB_LIBRARY= /home/hhs/hwdb/rocksdb/librocksdb.a -lbz2 -ldl -lz -lzstd -llz4 -lsnappy
ROCKSDB_DEFS= -DYCSB_ROCKSDB
ROCKSDB_OBJECTS=$(ROCKSDB_SOURCES:.cc=.o)
##

##wiredtiger
WIREDTIGER_FLAGS= -I/home/hhs/hwdb/wiredtiger/build/include
WIREDTIGER_SOURCES= db/wiredtiger_db.cc
WIREDTIGER_LIBRARY= /home/hhs/hwdb/wiredtiger/build/lib/libwiredtiger.a -ldl
WIREDTIGER_DEFS= -DYCSB_WIREDTIGER
WIREDTIGER_OBJECTS=$(WIREDTIGER_SOURCES:.cc=.o)
##

##leveldb
LEVELDB_SOURCES= db/leveldb_db.cc
LEVELDB_LIBRARY= /home/hhs/hwdb/leveldb/build/libleveldb.a -lsnappy
LEVELDB_DEFS= -DYCSB_LEVELDB
LEVELDB_OBJECTS=$(LEVELDB_SOURCES:.cc=.o)
##

OBJECTS=$(LIB_SOURCES:.cc=.o)
EXEC=ycsbc

ONLY_HWDB_SOURCES=$(LIB_SOURCES) $(HWDB_SOURCES)
ONLY_ROCKSDB_SOURCES=$(LIB_SOURCES) $(ROCKSDB_SOURCES)
ONLY_WIREDTIGER_SOURCES=$(LIB_SOURCES) $(WIREDTIGER_SOURCES)
ONLY_LEVELDB_SOURCES=$(LIB_SOURCES) $(LEVELDB_SOURCES)

ALL_FLAGS=$(HWDB_FLAGS) $(ROCKSDB_FLAGS) $(WIREDTIGER_FLAGS) $(LEVELDB_FLAGS)
ALL_SOURCES=$(LIB_SOURCES) $(HWDB_SOURCES) $(ROCKSDB_SOURCES) $(WIREDTIGER_SOURCES) $(LEVELDB_SOURCES)
ALL_LIBRARY=$(HWDB_LIBRARY) $(ROCKSDB_LIBRARY) $(WIREDTIGER_LIBRARY) $(LEVELDB_LIBRARY)
ALL_DEFS=$(HWDB_DEFS) $(ROCKSDB_DEFS) $(WIREDTIGER_DEFS) $(LEVELDB_DEFS)

all: clean
	$(CC) $(CXXFLAGS) $(ALL_FLAGS) $(ALL_DEFS) ycsbc.cc $(ALL_SOURCES) -o $(EXEC) $(LDFLAGS) $(ALL_LIBRARY)

hwdb: clean
	$(CC) $(CXXFLAGS) $(HWDB_FLAGS) $(HWDB_DEFS) ycsbc.cc $(ONLY_HWDB_SOURCES) -o $(EXEC) $(LDFLAGS) $(HWDB_LIBRARY)

rocksdb: clean
	$(CC) $(CXXFLAGS) $(ROCKSDB_FLAGS) $(ROCKSDB_DEFS) ycsbc.cc $(ONLY_ROCKSDB_SOURCES) -o $(EXEC) $(LDFLAGS) $(ROCKSDB_LIBRARY)

wiredtiger: clean
	$(CC) $(CXXFLAGS) $(WIREDTIGER_FLAGS) $(WIREDTIGER_DEFS) ycsbc.cc $(ONLY_WIREDTIGER_SOURCES) -o $(EXEC) $(LDFLAGS) $(WIREDTIGER_LIBRARY)

leveldb: clean
	$(CC) $(CXXFLAGS) $(LEVELDB_FLAGS) $(LEVELDB_DEFS) ycsbc.cc $(ONLY_LEVELDB_SOURCES) -o $(EXEC) $(LDFLAGS) $(LEVELDB_LIBRARY)

clean:
	rm -f $(EXEC) 

.PHONY: clean rocksdb hwdb wiredtiger leveldb

