
CC=g++
CXXFLAGS= -std=c++11 -g -Wall -I./ 
LDFLAGS= -lpthread 

LIB_SOURCES= \
		core/core_workload.cc  \
		db/db_factory.cc   \
		db/hashtable_db.cc  \
		lib/histogram.cc \

##HWDB
HWDB_SOURCES= db/hwdb_db.cc
HWDB_LIBRARY= -lhwdb
HWDB_DEFS= -DYCSB_HWDB
HWDB_OBJECTS=$(HWDB_SOURCES:.cc=.o)
##

##rocksdb
ROCKSDB_SOURCES= db/rocksdb_db.cc
ROCKSDB_LIBRARY= -lrocksdb -lz -lzstd -llz4 -lsnappy
ROCKSDB_DEFS= -DYCSB_ROCKSDB
ROCKSDB_OBJECTS=$(ROCKSDB_SOURCES:.cc=.o)
##

##wiredtiger
WIREDTIGER_SOURCES= db/wiredtiger_db.cc
WIREDTIGER_LIBRARY= /home/hhs/hwdb/wiredtiger/build/libwiredtiger.so
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

ALL_SOURCES=$(LIB_SOURCES) $(HWDB_SOURCES) $(ROCKSDB_SOURCES) $(WIREDTIGER_SOURCES)
ALL_LIBRARY=$(HWDB_LIBRARY) $(ROCKSDB_LIBRARY) $(WIREDTIGER_LIBRARY) $(LEVELDB_LIBRARY)
ALL_DEFS=$(HWDB_DEFS) $(ROCKSDB_DEFS) $(WIREDTIGER_DEFS) $(LEVELDB_DEFS)

all: clean
	$(CC) $(CXXFLAGS) $(ALL_DEFS) ycsbc.cc $(ALL_SOURCES) -o $(EXEC) $(LDFLAGS) $(ALL_LIBRARY)

hwdb: clean
	$(CC) $(CXXFLAGS) $(HWDB_DEFS) ycsbc.cc $(ONLY_HWDB_SOURCES) -o $(EXEC) $(LDFLAGS) $(HWDB_LIBRARY)

rocksdb: clean
	$(CC) $(CXXFLAGS) $(ROCKSDB_DEFS) ycsbc.cc $(ONLY_ROCKSDB_SOURCES) -o $(EXEC) $(LDFLAGS) $(ROCKSDB_LIBRARY)

wiredtiger: clean
	$(CC) $(CXXFLAGS) $(WIREDTIGER_DEFS) ycsbc.cc $(ONLY_WIREDTIGER_SOURCES) -o $(EXEC) $(LDFLAGS) $(WIREDTIGER_LIBRARY)

leveldb: clean
	$(CC) $(CXXFLAGS) $(LEVELDB_DEFS) ycsbc.cc $(ONLY_LEVELDB_SOURCES) -o $(EXEC) $(LDFLAGS) $(LEVELDB_LIBRARY)

clean:
	rm -f $(EXEC) 

.PHONY: clean rocksdb hwdb wiredtiger leveldb

