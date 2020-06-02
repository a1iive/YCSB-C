
CC=g++
CXXFLAGS= -std=c++11 -g -Wall -I./ 
LDFLAGS= -lpthread 

LIB_SOURCES= \
		core/core_workload.cc  \
		db/db_factory.cc   \
		db/hashtable_db.cc  \

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

##rocksdb
WIREDTIGER_SOURCES= db/wiredtiger_db.cc
WIREDTIGER_LIBRARY= -lwiredtiger
WIREDTIGER_DEFS= -DYCSB_WIREDTIGER
WIREDTIGER_OBJECTS=$(WIREDTIGER_SOURCES:.cc=.o)
##

OBJECTS=$(LIB_SOURCES:.cc=.o)
EXEC=ycsbc

ONLY_HWDB_SOURCES=$(LIB_SOURCES) $(HWDB_SOURCES)
ONLY_ROCKSDB_SOURCES=$(LIB_SOURCES) $(ROCKSDB_SOURCES)
ONLY_WIREDTIGER_SOURCES=$(LIB_SOURCES) $(WIREDTIGER_SOURCES)
ALL_SOURCES=$(LIB_SOURCES) $(HWDB_SOURCES) $(ROCKSDB_SOURCES) $(WIREDTIGER_SOURCES)

all: clean
	$(CC) $(CXXFLAGS) $(HWDB_DEFS) $(ROCKSDB_DEFS) $(WIREDTIGER_DEFS) ycsbc.cc $(ALL_SOURCES) -o $(EXEC) $(LDFLAGS) $(HWDB_LIBRARY) $(ROCKSDB_LIBRARY) $(WIREDTIGER_LIBRARY)

hwdb: clean
	$(CC) $(CXXFLAGS) $(HWDB_DEFS) ycsbc.cc $(ONLY_HWDB_SOURCES) -o $(EXEC) $(LDFLAGS) $(HWDB_LIBRARY)

rocksdb: clean
	$(CC) $(CXXFLAGS) $(ROCKSDB_DEFS) ycsbc.cc $(ONLY_ROCKSDB_SOURCES) -o $(EXEC) $(LDFLAGS) $(ROCKSDB_LIBRARY)

wiredtiger: clean
	$(CC) $(CXXFLAGS) $(WIREDTIGER_DEFS) ycsbc.cc $(ONLY_WIREDTIGER_SOURCES) -o $(EXEC) $(LDFLAGS) $(WIREDTIGER_LIBRARY)

clean:
	rm -f $(EXEC) 

.PHONY: clean rocksdb hwdb wiredtiger

