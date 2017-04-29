#include <iostream>
#include "8080emuCPP.h"
#include "gtuos.h"
#include "memory.h"
#include <cstring>

using namespace std;

uint64_t GTUOS::handleCall(const CPU8080 & cpu){
    unsigned int myint = 0;
    switch(cpu.state->a){
        case 1: // PRINT_B
            PRINT_B(cpu);
            break;
        case 2: // PRINT_MEM
            PRINT_MEM(cpu);
            break;
        case 3: // READ_B
            READ_B(cpu);
            break;
        case 4: // READ_MEM
            READ_MEM(cpu);
            break;
        case 5: // PRINT_STR
            PRINT_STR(cpu);
            break;
        case 6: // READ_STR
            READ_STR(cpu); 
            break;
        case 7:
            FORK(cpu); 
            break;
        case 8:
            EXEC(cpu);
            break;
        case 9:
            WAITPID(cpu);
            break;
        default:
            cout << "fault" << endl;
    
    }
}

void GTUOS::PRINT_B(const CPU8080 & cpu){
    cout << "System Call: PRINT_B" << endl;
    cout << "Value of B " << (unsigned)(cpu.state->b) << endl;
}

void GTUOS::READ_B(const CPU8080 & cpu){
    unsigned int myint;
    cout << "System Call: READ_B" << endl;
    cin >> hex >> myint;
    //cout << "myint: " << myint << endl;
    cpu.state->b = myint;
    //cout << "b: " << (unsigned)cpu.state->b <<endl;

}

void GTUOS::PRINT_MEM(const CPU8080 & cpu){
    uint16_t wd;
    cout << "System Call: PRINT_MEM" << endl;
    wd = ((uint16_t)cpu.state->b << 8) | cpu.state->c;
    cout << "Value of MEM " << (unsigned)(cpu.memory) << endl;
}

void GTUOS::READ_MEM(const CPU8080 & cpu){
    int myint;
    uint16_t wd;
    
    cout << "System Call: READ_MEM" << endl;
    cin >> hex >> myint;
    wd = ((uint16_t)cpu.state->b << 8) | cpu.state->c;
    cpu.memory->at(wd) = myint;
}

void GTUOS::PRINT_STR(const CPU8080 & cpu){
    uint16_t wd;
    cout << "System Call: PRINT_STR" << endl;
    wd = ((uint16_t)cpu.state->b << 8) | cpu.state->c;
    uint8_t index = cpu.memory->at(wd);
    while(cpu.memory->at(wd) != '\0'){
        cout << (char)(cpu.memory->at(wd));
        wd++;
    } 
    cout << endl;   
}

void GTUOS::READ_STR(const CPU8080 & cpu){
    string s;
    int i=0;
    uint16_t wd;
    
    cout << "System Call: READ_STR" << endl;
    cin >> s;
    wd = ((uint16_t)cpu.state->b << 8) | cpu.state->c;
    i=0;
    while(s[i] != '\0'){
        cpu.memory->at(wd) = (unsigned char)s[i];
        wd++;
        i++;
    }
    cpu.memory->at(wd) = s[i];
}

uint8_t GTUOS::FORK(const CPU8080 & cpu){    
    cout << "System Call: FORK" << endl;
    
    char filename1[1024] = "p1.com"; 
    char filename2[1024] = "p2.com"; 
    char filename3[1024] = "p3.com"; 
    char filename[1024] = ""; 
    int size = 7;
    uint16_t wd;
    int index = 0;
    
    pageTable[tableIndex].reg = (unsigned)(cpu.state->a);
    
    if(tableIndex == 0){
        strcpy(filename, filename1);
        
        pageTable[tableIndex].base = 0;
        pageTable[tableIndex].limit = 15;
        
        pageTable[tableIndex].startTime = 0;
        pageTable[tableIndex].sofarCycle = 0;
        pageTable[tableIndex].state = 0;
        
        tableIndex++;
    }
    else if(tableIndex == 1){
        strcpy(filename, filename2);
        
        pageTable[tableIndex].base = 16;
        pageTable[tableIndex].limit = 32;
        
        pageTable[tableIndex].startTime = 100;
        pageTable[tableIndex].sofarCycle = 0;
        pageTable[tableIndex].state = 0;
        
        tableIndex++;
    }
    else if(tableIndex == 2){
        strcpy(filename, filename3);
        
        pageTable[tableIndex].base = 33;
        pageTable[tableIndex].limit = 49;
        
        pageTable[tableIndex].startTime = 200;
        pageTable[tableIndex].sofarCycle = 0;
        pageTable[tableIndex].state = 0;
        
        tableIndex++;
    }
    
    strcat(filename, "\0");
    
    wd = ((uint16_t)cpu.state->b << 8) | cpu.state->c;
    while(index < size){
        cpu.memory->at(wd) = filename[index];
        wd++;
        index++;
    }
    
    return cpu.state->b;
}

void GTUOS::EXEC(const CPU8080 & cpu){   
    cout << "System Call: EXEC" << endl;

    if(pageTable[tableIndex].state == 0){
        pageTable[tableIndex].state = 2;

        int index = 0;
        uint16_t wd;
        wd = ((uint16_t)cpu.state->b << 8) | cpu.state->c;
        while(cpu.memory->at(wd) != '\0'){
            pageTable[tableIndex].filename[index] =(char)(cpu.memory->at(wd));
            wd++;
            index++;
        }
        
        memory mem;
        int cycle = 0;
	    CPU8080 process(&mem);
	    GTUOS	os;
        process.ReadFileIntoMemoryAt(pageTable[tableIndex].filename, (uint16_t)cpu.state->b);
        
        do{
		    process.Emulate8080p(0);
		    if(process.isSystemCall())
			    os.handleCall(process);
	    }	while (!process.isHalted());
	
    }
}

void GTUOS::WAITPID(const CPU8080 & cpu){   
    cout << "System Call: WAITPID" << endl;
    
    if(pageTable[tableIndex].state == 2){
        pageTable[tableIndex].state = 1;
    }
}

int GTUOS::calculateCycle(const CPU8080 & cpu){
    int cycle = 0;
    switch(cpu.state->a){
        case 1: // PRINT_B
        case 2: // PRINT_MEM
        case 3: // READ_B
        case 4: // READ_MEM
            cycle = 10;
            break;
        case 5: // PRINT_STR 
        case 6: // READ_STR
            cycle = 100;
            break;
        case 7:
            cycle = 50;
            break;
        case 8:
        case 9:
            cycle = 80;
            break;
    }
    return cycle;
}
