#ifndef H_GTUOS
#define H_GTUOS

#include "8080emuCPP.h"

using namespace std;

struct pageTable_t{
    char filename[1024];
    int reg;
    int base;
    int limit;
    int PID; //?
    int pPID; //?
    int startTime;
    int sofarCycle;
    int state; //2:running, 1:blocked, 0:ready
    int phAdress; //?
}; 

class GTUOS{
	public:
	    pageTable_t pageTable[3];
	    int tableIndex;
		uint64_t handleCall(const CPU8080 & cpu);
        int calculateCycle(const CPU8080 & cpu); 
		void PRINT_B(const CPU8080 & cpu);
		void READ_B(const CPU8080 & cpu);
		void PRINT_MEM(const CPU8080 & cpu);
		void READ_MEM(const CPU8080 & cpu);
		void PRINT_STR(const CPU8080 & cpu);
		void READ_STR(const CPU8080 & cpu);
		uint8_t FORK(const CPU8080 & cpu);
        void EXEC(const CPU8080 & cpu);
        void WAITPID(const CPU8080 & cpu);
};

#endif
