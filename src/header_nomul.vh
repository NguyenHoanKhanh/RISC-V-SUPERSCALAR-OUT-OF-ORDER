// ============================================================
// Opcode field: instruction[6:0]
// ============================================================
// Used to identify the main instruction format/type.
// ============================================================

`define OPCODE_WIDTH 7

`define RTYPE  7'b0110011   // R-type: register-register ALU ops
`define ITYPE  7'b0010011   // I-type: immediate ALU ops
`define STORE  7'b0100011   // S-type: store instructions
`define LOAD   7'b0000011   // I-type: load instructions
`define BTYPE  7'b1100011   // B-type: branch instructions
`define JAL    7'b1101111   // J-type: jump and link
`define LUI    7'b0110111   // U-type: load upper immediate
`define AUIPC  7'b0010111   // U-type: add upper immediate to PC

// ============================================================
// funct3 field: instruction[14:12]
// ============================================================
// funct3 meaning depends on opcode.
// The same 3-bit value can represent different instructions.
// ============================================================

`define FUNCT3_WIDTH 3


// ============================================================
// R-type / I-type ALU funct3 values
// Used when opcode is RTYPE or ITYPE.
// For RTYPE, funct7 may also be needed.
// ============================================================

`define ADD   3'b000   // RTYPE + ZERO = ADD, RTYPE + SUB = SUB, ITYPE = ADDI
`define SLL   3'b001   // Shift left logical
`define SLT   3'b010   // Set less than, signed
`define SLTU  3'b011   // Set less than, unsigned
`define XOR   3'b100   // Bitwise XOR
`define SRL   3'b101   // RTYPE/ITYPE + ZERO = SRL/SRLI, + SRA = SRA/SRAI
`define OR    3'b110   // Bitwise OR
`define AND   3'b111   // Bitwise AND


// ============================================================
// Load funct3 values
// Used only when opcode is LOAD.
// ============================================================

`define LB    3'b000   // Load byte, signed
`define LH    3'b001   // Load halfword, signed
`define LW    3'b010   // Load word
`define LBU   3'b100   // Load byte, unsigned
`define LHU   3'b101   // Load halfword, unsigned


// ============================================================
// Store funct3 values
// Used only when opcode is STORE.
// ============================================================

`define SB    3'b000   // Store byte
`define SH    3'b001   // Store halfword
`define SW    3'b010   // Store word


// ============================================================
// Multiply extension funct3 values
// Used when:
//   opcode = RTYPE
//   funct7 = MUL_7
// ============================================================

`define MUL     3'b000   // Multiply low 32 bits
`define MULH    3'b001   // Multiply high, signed x signed
`define MULHSU  3'b010   // Multiply high, signed x unsigned
`define MULHU   3'b011   // Multiply high, unsigned x unsigned

// ============================================================
// Divide/Remainder extension funct3 values
// Used when:
//   opcode = RTYPE
//   funct7 = MUL_7
// ============================================================

`define DIV     3'b100   // Signed quotient
`define DIVU    3'b101   // Unsigned quotient
`define REM     3'b110   // Signed remainder
`define REMU    3'b111   // Unsigned remainder

// ============================================================
// Branch funct3 values
// Used only when opcode is BTYPE.
// ============================================================

`define BEQ   3'b000   // Branch if equal
`define BNE   3'b001   // Branch if not equal
`define BLT   3'b100   // Branch if less than, signed
`define BGE   3'b101   // Branch if greater or equal, signed
`define BLTU  3'b110   // Branch if less than, unsigned
`define BGEU  3'b111   // Branch if greater or equal, unsigned


// ============================================================
// funct7 field: instruction[31:25]
// ============================================================
// Used mainly by R-type instructions.
// Helps distinguish ADD/SUB, SRL/SRA, and normal ALU/MUL.
// ============================================================

`define FUNCT7_WIDTH 7

`define ZERO   7'b0000000   // Normal ALU operation: ADD, SLL, SLT, XOR, SRL, OR, AND
`define SUB    7'b0100000   // Used with funct3 ADD to mean SUB
`define SRA    7'b0100000   // Used with funct3 SRL to mean SRA
`define MUL_7  7'b0000001   // RISC-V M extension: MUL, MULH, MULHSU, MULHU


// ============================================================
// Datapath / processor configuration
// ============================================================
// These are general hardware parameters.
// ============================================================

`define ALU_CONTROL 4       // ALU control signal width

`define IWIDTH      32      // Instruction width
`define IMM_WIDTH   32      // Immediate width after sign/zero extension
`define DWIDTH      32      // Data width / register width
`define PC_WIDTH    32      // Program counter width

`define DEPTH       4096     // Memory depth, adjust depending on your design
`define MEM_DEPTH   4096

`define SHAMT_WIDTH 5       // Shift amount width for 32-bit data
`define AWIDTH      5       // Register address width, 32 registers -> 5 bits
`define AWIDTH_MEM  32      // Memory address width
`define MULQ_SIZE   8
`define DIVQ_SIZE   8

// ============================================================
// Out-of-order CPU structures
// ============================================================
// ROB: Reorder Buffer
// RS : Reservation Station
// RAT: Register Alias Table
// ============================================================

`define ROB_SIZE    64
`define RS_SIZE     32
`define RAT_SIZE    7

// Number of bits needed to index ROB.
// For ROB_SIZE = 32, ROB_IDX_W = 5.
`define ROB_IDX_W   $clog2(`ROB_SIZE)
