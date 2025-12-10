# Jada Brown 800743234 Project 3 Virtual Memory ####################################

# ############################################################### #
# P3__solution_FA_2025.asm                                        #
#                                                                 #
# This assembly program translates a combination of "segment      #
# number" and "the offset address in a memory segment" to         #
# a physical memory address through the virtual memory.           #
#                                                                 #
# a given virtual memory page number and a virtual memory offset  #
# memory address to find a physical memory address.               #
#                                                                 #
# I. Inputs: this rpogram prompts an input for:                   #
#    (1) a memory segment number                                  #
#    (2) the offset address in the memory segment                 #
#    (3) the page size in bytes (common for the virtual memory    #
#        and the physical memory)                                 #
#                                                                 #
# II. The segment table and the virtual memory tables:            #
#    (1) segment table: "SEG_TABLE" (its size is specified by     #
#        "SEG_TABLE_SIZE")                                        #
#    (2) VMT table: "VMT" (its size is specified by "VMT_SIZE")   #
#                                                                 #
# III. the registers used are listed as:                          #
#      $s0: the size of the segment table
#      $s1: the size of the VMT
#      $s2: the target segment number
#      $s3: the target segment offset address
#      $s4: the virtual memory page size
#      $t0: the base address of the target segment
#      $t1: the limit (the size) of the target segment
#      $t2: the target (linear) virtual memory address
#      $t3: the virtual memory page number
#      $t4: the physical memory page number
#      $t5: the valid flag
#      $t6: the offset address in the virtual memory page
#      $t7: the starting memory address of the target physical memory page
#      $t8: the final physical memory address
#                                                                 #
# IV. test sample:                                                #
#    Segment # = 1                                                #
#    Segment Offset = 100000                                      #
#    Page Size = 10240                                            #
#                                                                 #
#    9:08 AM, November 17, 2025                                   #
# ############################################################### #   

.data
	STR_MESSAGE0: .asciiz "\n"
	STR_MESSAGE1: .asciiz "The target segment number: "
	STR_MESSAGE2: .asciiz "The target segment offset address: "
	STR_MESSAGE3: .asciiz "The virtual memory page size (in bytes): "

	STR_MESSAGE4: .asciiz "      Segmentation Fault (process terminated) ...\n"
	STR_MESSAGE5: .asciiz "      NO Segmentation Fault ...\n"

	STR_MESSAGE6: .asciiz "Virtual Memory Page Number: "
	STR_MESSAGE7: .asciiz "Virtual Memory Offset Address: "

	STR_MESSAGE8: .asciiz "      Page Fault ...\n"
	
	STR_MESSAGE9: .asciiz "Physical Memory Page Number: "
	STR_MESSAGE10: .asciiz "Physical Memory Offset Address: "
	STR_MESSAGE11: .asciiz "Physical Memory Address: "
	STR_MESSAGE12: .asciiz "Propcess terminated .................\n"

        STR_MESSAGE20: .asciiz "Segment Table Size: "
        STR_MESSAGE21: .asciiz "VMT Size: "

        STR_MESSAGE30: .asciiz "the base address of the target segment: "
        STR_MESSAGE31: .asciiz "the the limit (the size) of the target segment: "
        STR_MESSAGE32: .asciiz "the the target (linear) virtual memory address: "
        STR_MESSAGE33: .asciiz "the virtual memory page number: "
        STR_MESSAGE34: .asciiz "the physical memory page number: "
        STR_MESSAGE35: .asciiz "the valid flag: "
        STR_MESSAGE36: .asciiz "the starting memory address of the target physical memory page: "
        STR_MESSAGE37: .asciiz "the offset address in the (virtual) memory page: "

        STR_SEPARATOR: .asciiz "*******************************************************"

# Segment Table Size ***********************************************
SEG_TABLE_SIZE:

.word  8 # the segment table size (in the number of the segments)

# Segment Table ****************************************************
#	.word <Segment Base>, <Segment Limit>
SEG_TABLE:

.word	0,		4193999		# for segment 0
.word	4194000,	2304561		# for segment 1
.word	6498562,	189652		# for segment 2
.word	6688215,	3964511		# for segment 3
.word	10652727,	876901		# for segment 4
.word	11529629,	1009452		# for segment 5
.word	12539082,	4193999		# for segment 6
.word	16733082,	1823003		# for segment 7


# VMT Size *********************************************************
VMT_SIZE:

.word  1024 # the VMT size (in bytes)

# VMT (Virtual Memory Table ****************************************
#     .word   <Physical Page #>, <Valid Flag>

VMT:

.word  108, 0   # the physical page number and the valid flag for virtual page 0
.word  97, 0   # the physical page number and the valid flag for virtual page 1
.word  118, 0   # the physical page number and the valid flag for virtual page 2
.word  14, 0   # the physical page number and the valid flag for virtual page 3
.word  47, 0   # the physical page number and the valid flag for virtual page 4
.word  64, 0   # the physical page number and the valid flag for virtual page 5
.word  33, 0   # the physical page number and the valid flag for virtual page 6
.word  117, 0   # the physical page number and the valid flag for virtual page 7
.word  127, 0   # the physical page number and the valid flag for virtual page 8
.word  126, 0   # the physical page number and the valid flag for virtual page 9
.word  31, 0   # the physical page number and the valid flag for virtual page 10
.word  15, 0   # the physical page number and the valid flag for virtual page 11
.word  48, 0   # the physical page number and the valid flag for virtual page 12
.word  44, 0   # the physical page number and the valid flag for virtual page 13
.word  16, 0   # the physical page number and the valid flag for virtual page 14
.word  17, 0   # the physical page number and the valid flag for virtual page 15
.word  116, 0   # the physical page number and the valid flag for virtual page 16
.word  72, 0   # the physical page number and the valid flag for virtual page 17
.word  69, 0   # the physical page number and the valid flag for virtual page 18
.word  16, 0   # the physical page number and the valid flag for virtual page 19
.word  89, 0   # the physical page number and the valid flag for virtual page 20
.word  52, 0   # the physical page number and the valid flag for virtual page 21
.word  109, 0   # the physical page number and the valid flag for virtual page 22
.word  21, 0   # the physical page number and the valid flag for virtual page 23
.word  19, 0   # the physical page number and the valid flag for virtual page 24
.word  103, 0   # the physical page number and the valid flag for virtual page 25
.word  113, 0   # the physical page number and the valid flag for virtual page 26
.word  115, 0   # the physical page number and the valid flag for virtual page 27
.word  124, 0   # the physical page number and the valid flag for virtual page 28
.word  99, 0   # the physical page number and the valid flag for virtual page 29
.word  28, 0   # the physical page number and the valid flag for virtual page 30
.word  88, 0   # the physical page number and the valid flag for virtual page 31
.word  89, 0   # the physical page number and the valid flag for virtual page 32
.word  102, 0   # the physical page number and the valid flag for virtual page 33
.word  127, 0   # the physical page number and the valid flag for virtual page 34
.word  35, 0   # the physical page number and the valid flag for virtual page 35
.word  95, 0   # the physical page number and the valid flag for virtual page 36
.word  101, 0   # the physical page number and the valid flag for virtual page 37
.word  20, 0   # the physical page number and the valid flag for virtual page 38
.word  117, 0   # the physical page number and the valid flag for virtual page 39
.word  118, 0   # the physical page number and the valid flag for virtual page 40
.word  54, 0   # the physical page number and the valid flag for virtual page 41
.word  33, 0   # the physical page number and the valid flag for virtual page 42
.word  11, 0   # the physical page number and the valid flag for virtual page 43
.word  60, 0   # the physical page number and the valid flag for virtual page 44
.word  13, 0   # the physical page number and the valid flag for virtual page 45
.word  95, 0   # the physical page number and the valid flag for virtual page 46
.word  75, 0   # the physical page number and the valid flag for virtual page 47
.word  77, 0   # the physical page number and the valid flag for virtual page 48
.word  41, 0   # the physical page number and the valid flag for virtual page 49
.word  92, 0   # the physical page number and the valid flag for virtual page 50
.word  28, 0   # the physical page number and the valid flag for virtual page 51
.word  66, 0   # the physical page number and the valid flag for virtual page 52
.word  79, 0   # the physical page number and the valid flag for virtual page 53
.word  30, 0   # the physical page number and the valid flag for virtual page 54
.word  123, 0   # the physical page number and the valid flag for virtual page 55
.word  119, 0   # the physical page number and the valid flag for virtual page 56
.word  120, 0   # the physical page number and the valid flag for virtual page 57
.word  9, 0   # the physical page number and the valid flag for virtual page 58
.word  76, 0   # the physical page number and the valid flag for virtual page 59
.word  18, 0   # the physical page number and the valid flag for virtual page 60
.word  71, 0   # the physical page number and the valid flag for virtual page 61
.word  3, 0   # the physical page number and the valid flag for virtual page 62
.word  109, 0   # the physical page number and the valid flag for virtual page 63
.word  64, 0   # the physical page number and the valid flag for virtual page 64
.word  61, 0   # the physical page number and the valid flag for virtual page 65
.word  85, 0   # the physical page number and the valid flag for virtual page 66
.word  17, 0   # the physical page number and the valid flag for virtual page 67
.word  66, 0   # the physical page number and the valid flag for virtual page 68
.word  48, 0   # the physical page number and the valid flag for virtual page 69
.word  84, 0   # the physical page number and the valid flag for virtual page 70
.word  76, 0   # the physical page number and the valid flag for virtual page 71
.word  41, 0   # the physical page number and the valid flag for virtual page 72
.word  121, 0   # the physical page number and the valid flag for virtual page 73
.word  66, 0   # the physical page number and the valid flag for virtual page 74
.word  106, 0   # the physical page number and the valid flag for virtual page 75
.word  93, 0   # the physical page number and the valid flag for virtual page 76
.word  110, 0   # the physical page number and the valid flag for virtual page 77
.word  111, 0   # the physical page number and the valid flag for virtual page 78
.word  5, 0   # the physical page number and the valid flag for virtual page 79
.word  100, 0   # the physical page number and the valid flag for virtual page 80
.word  16, 0   # the physical page number and the valid flag for virtual page 81
.word  35, 0   # the physical page number and the valid flag for virtual page 82
.word  87, 0   # the physical page number and the valid flag for virtual page 83
.word  97, 0   # the physical page number and the valid flag for virtual page 84
.word  5, 0   # the physical page number and the valid flag for virtual page 85
.word  64, 0   # the physical page number and the valid flag for virtual page 86
.word  76, 0   # the physical page number and the valid flag for virtual page 87
.word  91, 0   # the physical page number and the valid flag for virtual page 88
.word  72, 0   # the physical page number and the valid flag for virtual page 89
.word  36, 0   # the physical page number and the valid flag for virtual page 90
.word  91, 0   # the physical page number and the valid flag for virtual page 91
.word  64, 0   # the physical page number and the valid flag for virtual page 92
.word  31, 0   # the physical page number and the valid flag for virtual page 93
.word  77, 0   # the physical page number and the valid flag for virtual page 94
.word  23, 0   # the physical page number and the valid flag for virtual page 95
.word  42, 0   # the physical page number and the valid flag for virtual page 96
.word  77, 0   # the physical page number and the valid flag for virtual page 97
.word  64, 0   # the physical page number and the valid flag for virtual page 98
.word  1, 0   # the physical page number and the valid flag for virtual page 99
.word  96, 0   # the physical page number and the valid flag for virtual page 100
.word  9, 0   # the physical page number and the valid flag for virtual page 101
.word  43, 0   # the physical page number and the valid flag for virtual page 102
.word  33, 0   # the physical page number and the valid flag for virtual page 103
.word  32, 0   # the physical page number and the valid flag for virtual page 104
.word  48, 0   # the physical page number and the valid flag for virtual page 105
.word  73, 0   # the physical page number and the valid flag for virtual page 106
.word  85, 0   # the physical page number and the valid flag for virtual page 107
.word  28, 0   # the physical page number and the valid flag for virtual page 108
.word  55, 0   # the physical page number and the valid flag for virtual page 109
.word  6, 0   # the physical page number and the valid flag for virtual page 110
.word  104, 0   # the physical page number and the valid flag for virtual page 111
.word  66, 0   # the physical page number and the valid flag for virtual page 112
.word  99, 0   # the physical page number and the valid flag for virtual page 113
.word  100, 0   # the physical page number and the valid flag for virtual page 114
.word  102, 0   # the physical page number and the valid flag for virtual page 115
.word  64, 0   # the physical page number and the valid flag for virtual page 116
.word  60, 0   # the physical page number and the valid flag for virtual page 117
.word  29, 0   # the physical page number and the valid flag for virtual page 118
.word  47, 0   # the physical page number and the valid flag for virtual page 119
.word  72, 0   # the physical page number and the valid flag for virtual page 120
.word  63, 0   # the physical page number and the valid flag for virtual page 121
.word  10, 0   # the physical page number and the valid flag for virtual page 122
.word  75, 0   # the physical page number and the valid flag for virtual page 123
.word  16, 0   # the physical page number and the valid flag for virtual page 124
.word  83, 0   # the physical page number and the valid flag for virtual page 125
.word  67, 0   # the physical page number and the valid flag for virtual page 126
.word  125, 0   # the physical page number and the valid flag for virtual page 127
.word  30, 0   # the physical page number and the valid flag for virtual page 128
.word  126, 0   # the physical page number and the valid flag for virtual page 129
.word  8, 0   # the physical page number and the valid flag for virtual page 130
.word  27, 0   # the physical page number and the valid flag for virtual page 131
.word  66, 0   # the physical page number and the valid flag for virtual page 132
.word  89, 0   # the physical page number and the valid flag for virtual page 133
.word  95, 0   # the physical page number and the valid flag for virtual page 134
.word  28, 0   # the physical page number and the valid flag for virtual page 135
.word  100, 0   # the physical page number and the valid flag for virtual page 136
.word  65, 0   # the physical page number and the valid flag for virtual page 137
.word  127, 0   # the physical page number and the valid flag for virtual page 138
.word  115, 0   # the physical page number and the valid flag for virtual page 139
.word  127, 0   # the physical page number and the valid flag for virtual page 140
.word  80, 0   # the physical page number and the valid flag for virtual page 141
.word  109, 0   # the physical page number and the valid flag for virtual page 142
.word  28, 0   # the physical page number and the valid flag for virtual page 143
.word  110, 0   # the physical page number and the valid flag for virtual page 144
.word  11, 0   # the physical page number and the valid flag for virtual page 145
.word  101, 0   # the physical page number and the valid flag for virtual page 146
.word  116, 0   # the physical page number and the valid flag for virtual page 147
.word  103, 0   # the physical page number and the valid flag for virtual page 148
.word  93, 0   # the physical page number and the valid flag for virtual page 149
.word  123, 0   # the physical page number and the valid flag for virtual page 150
.word  77, 0   # the physical page number and the valid flag for virtual page 151
.word  69, 0   # the physical page number and the valid flag for virtual page 152
.word  69, 0   # the physical page number and the valid flag for virtual page 153
.word  2, 0   # the physical page number and the valid flag for virtual page 154
.word  66, 0   # the physical page number and the valid flag for virtual page 155
.word  10, 0   # the physical page number and the valid flag for virtual page 156
.word  75, 0   # the physical page number and the valid flag for virtual page 157
.word  45, 0   # the physical page number and the valid flag for virtual page 158
.word  72, 0   # the physical page number and the valid flag for virtual page 159
.word  36, 0   # the physical page number and the valid flag for virtual page 160
.word  56, 0   # the physical page number and the valid flag for virtual page 161
.word  116, 0   # the physical page number and the valid flag for virtual page 162
.word  6, 0   # the physical page number and the valid flag for virtual page 163
.word  111, 0   # the physical page number and the valid flag for virtual page 164
.word  6, 0   # the physical page number and the valid flag for virtual page 165
.word  57, 0   # the physical page number and the valid flag for virtual page 166
.word  103, 0   # the physical page number and the valid flag for virtual page 167
.word  124, 0   # the physical page number and the valid flag for virtual page 168
.word  22, 0   # the physical page number and the valid flag for virtual page 169
.word  44, 0   # the physical page number and the valid flag for virtual page 170
.word  109, 0   # the physical page number and the valid flag for virtual page 171
.word  17, 0   # the physical page number and the valid flag for virtual page 172
.word  33, 0   # the physical page number and the valid flag for virtual page 173
.word  108, 0   # the physical page number and the valid flag for virtual page 174
.word  72, 0   # the physical page number and the valid flag for virtual page 175
.word  112, 0   # the physical page number and the valid flag for virtual page 176
.word  113, 0   # the physical page number and the valid flag for virtual page 177
.word  111, 0   # the physical page number and the valid flag for virtual page 178
.word  39, 0   # the physical page number and the valid flag for virtual page 179
.word  92, 0   # the physical page number and the valid flag for virtual page 180
.word  81, 0   # the physical page number and the valid flag for virtual page 181
.word  35, 0   # the physical page number and the valid flag for virtual page 182
.word  78, 0   # the physical page number and the valid flag for virtual page 183
.word  90, 0   # the physical page number and the valid flag for virtual page 184
.word  66, 0   # the physical page number and the valid flag for virtual page 185
.word  85, 0   # the physical page number and the valid flag for virtual page 186
.word  104, 0   # the physical page number and the valid flag for virtual page 187
.word  53, 0   # the physical page number and the valid flag for virtual page 188
.word  111, 0   # the physical page number and the valid flag for virtual page 189
.word  83, 0   # the physical page number and the valid flag for virtual page 190
.word  31, 0   # the physical page number and the valid flag for virtual page 191
.word  68, 0   # the physical page number and the valid flag for virtual page 192
.word  99, 0   # the physical page number and the valid flag for virtual page 193
.word  77, 0   # the physical page number and the valid flag for virtual page 194
.word  107, 0   # the physical page number and the valid flag for virtual page 195
.word  111, 0   # the physical page number and the valid flag for virtual page 196
.word  122, 0   # the physical page number and the valid flag for virtual page 197
.word  1, 0   # the physical page number and the valid flag for virtual page 198
.word  39, 0   # the physical page number and the valid flag for virtual page 199
.word  112, 0   # the physical page number and the valid flag for virtual page 200
.word  21, 0   # the physical page number and the valid flag for virtual page 201
.word  24, 0   # the physical page number and the valid flag for virtual page 202
.word  106, 0   # the physical page number and the valid flag for virtual page 203
.word  87, 0   # the physical page number and the valid flag for virtual page 204
.word  18, 0   # the physical page number and the valid flag for virtual page 205
.word  74, 0   # the physical page number and the valid flag for virtual page 206
.word  20, 0   # the physical page number and the valid flag for virtual page 207
.word  81, 0   # the physical page number and the valid flag for virtual page 208
.word  124, 0   # the physical page number and the valid flag for virtual page 209
.word  73, 0   # the physical page number and the valid flag for virtual page 210
.word  39, 0   # the physical page number and the valid flag for virtual page 211
.word  41, 0   # the physical page number and the valid flag for virtual page 212
.word  126, 0   # the physical page number and the valid flag for virtual page 213
.word  93, 0   # the physical page number and the valid flag for virtual page 214
.word  89, 0   # the physical page number and the valid flag for virtual page 215
.word  15, 0   # the physical page number and the valid flag for virtual page 216
.word  30, 0   # the physical page number and the valid flag for virtual page 217
.word  75, 0   # the physical page number and the valid flag for virtual page 218
.word  103, 0   # the physical page number and the valid flag for virtual page 219
.word  25, 0   # the physical page number and the valid flag for virtual page 220
.word  40, 0   # the physical page number and the valid flag for virtual page 221
.word  124, 0   # the physical page number and the valid flag for virtual page 222
.word  43, 0   # the physical page number and the valid flag for virtual page 223
.word  7, 0   # the physical page number and the valid flag for virtual page 224
.word  103, 0   # the physical page number and the valid flag for virtual page 225
.word  91, 0   # the physical page number and the valid flag for virtual page 226
.word  113, 0   # the physical page number and the valid flag for virtual page 227
.word  75, 0   # the physical page number and the valid flag for virtual page 228
.word  27, 0   # the physical page number and the valid flag for virtual page 229
.word  127, 0   # the physical page number and the valid flag for virtual page 230
.word  7, 0   # the physical page number and the valid flag for virtual page 231
.word  73, 0   # the physical page number and the valid flag for virtual page 232
.word  40, 0   # the physical page number and the valid flag for virtual page 233
.word  10, 0   # the physical page number and the valid flag for virtual page 234
.word  19, 0   # the physical page number and the valid flag for virtual page 235
.word  91, 0   # the physical page number and the valid flag for virtual page 236
.word  12, 0   # the physical page number and the valid flag for virtual page 237
.word  81, 0   # the physical page number and the valid flag for virtual page 238
.word  41, 0   # the physical page number and the valid flag for virtual page 239
.word  24, 0   # the physical page number and the valid flag for virtual page 240
.word  19, 0   # the physical page number and the valid flag for virtual page 241
.word  61, 0   # the physical page number and the valid flag for virtual page 242
.word  29, 0   # the physical page number and the valid flag for virtual page 243
.word  86, 0   # the physical page number and the valid flag for virtual page 244
.word  78, 0   # the physical page number and the valid flag for virtual page 245
.word  113, 0   # the physical page number and the valid flag for virtual page 246
.word  22, 0   # the physical page number and the valid flag for virtual page 247
.word  109, 0   # the physical page number and the valid flag for virtual page 248
.word  65, 0   # the physical page number and the valid flag for virtual page 249
.word  44, 0   # the physical page number and the valid flag for virtual page 250
.word  100, 0   # the physical page number and the valid flag for virtual page 251
.word  62, 0   # the physical page number and the valid flag for virtual page 252
.word  92, 0   # the physical page number and the valid flag for virtual page 253
.word  113, 0   # the physical page number and the valid flag for virtual page 254
.word  20, 0   # the physical page number and the valid flag for virtual page 255
.word  116, 0   # the physical page number and the valid flag for virtual page 256
.word  45, 0   # the physical page number and the valid flag for virtual page 257
.word  102, 0   # the physical page number and the valid flag for virtual page 258
.word  65, 0   # the physical page number and the valid flag for virtual page 259
.word  10, 0   # the physical page number and the valid flag for virtual page 260
.word  83, 0   # the physical page number and the valid flag for virtual page 261
.word  123, 0   # the physical page number and the valid flag for virtual page 262
.word  45, 0   # the physical page number and the valid flag for virtual page 263
.word  14, 0   # the physical page number and the valid flag for virtual page 264
.word  54, 0   # the physical page number and the valid flag for virtual page 265
.word  75, 0   # the physical page number and the valid flag for virtual page 266
.word  16, 0   # the physical page number and the valid flag for virtual page 267
.word  36, 0   # the physical page number and the valid flag for virtual page 268
.word  117, 0   # the physical page number and the valid flag for virtual page 269
.word  71, 0   # the physical page number and the valid flag for virtual page 270
.word  47, 0   # the physical page number and the valid flag for virtual page 271
.word  77, 0   # the physical page number and the valid flag for virtual page 272
.word  32, 0   # the physical page number and the valid flag for virtual page 273
.word  17, 0   # the physical page number and the valid flag for virtual page 274
.word  49, 0   # the physical page number and the valid flag for virtual page 275
.word  105, 0   # the physical page number and the valid flag for virtual page 276
.word  40, 0   # the physical page number and the valid flag for virtual page 277
.word  38, 0   # the physical page number and the valid flag for virtual page 278
.word  46, 0   # the physical page number and the valid flag for virtual page 279
.word  123, 0   # the physical page number and the valid flag for virtual page 280
.word  19, 0   # the physical page number and the valid flag for virtual page 281
.word  64, 0   # the physical page number and the valid flag for virtual page 282
.word  10, 0   # the physical page number and the valid flag for virtual page 283
.word  45, 0   # the physical page number and the valid flag for virtual page 284
.word  116, 0   # the physical page number and the valid flag for virtual page 285
.word  123, 0   # the physical page number and the valid flag for virtual page 286
.word  1, 0   # the physical page number and the valid flag for virtual page 287
.word  20, 0   # the physical page number and the valid flag for virtual page 288
.word  27, 0   # the physical page number and the valid flag for virtual page 289
.word  54, 0   # the physical page number and the valid flag for virtual page 290
.word  2, 0   # the physical page number and the valid flag for virtual page 291
.word  52, 0   # the physical page number and the valid flag for virtual page 292
.word  9, 0   # the physical page number and the valid flag for virtual page 293
.word  60, 0   # the physical page number and the valid flag for virtual page 294
.word  65, 0   # the physical page number and the valid flag for virtual page 295
.word  71, 0   # the physical page number and the valid flag for virtual page 296
.word  39, 0   # the physical page number and the valid flag for virtual page 297
.word  36, 0   # the physical page number and the valid flag for virtual page 298
.word  8, 0   # the physical page number and the valid flag for virtual page 299
.word  58, 0   # the physical page number and the valid flag for virtual page 300
.word  55, 0   # the physical page number and the valid flag for virtual page 301
.word  117, 0   # the physical page number and the valid flag for virtual page 302
.word  77, 0   # the physical page number and the valid flag for virtual page 303
.word  121, 0   # the physical page number and the valid flag for virtual page 304
.word  10, 0   # the physical page number and the valid flag for virtual page 305
.word  14, 0   # the physical page number and the valid flag for virtual page 306
.word  10, 0   # the physical page number and the valid flag for virtual page 307
.word  108, 0   # the physical page number and the valid flag for virtual page 308
.word  115, 0   # the physical page number and the valid flag for virtual page 309
.word  69, 0   # the physical page number and the valid flag for virtual page 310
.word  73, 0   # the physical page number and the valid flag for virtual page 311
.word  65, 0   # the physical page number and the valid flag for virtual page 312
.word  125, 0   # the physical page number and the valid flag for virtual page 313
.word  79, 0   # the physical page number and the valid flag for virtual page 314
.word  126, 0   # the physical page number and the valid flag for virtual page 315
.word  109, 0   # the physical page number and the valid flag for virtual page 316
.word  89, 0   # the physical page number and the valid flag for virtual page 317
.word  96, 0   # the physical page number and the valid flag for virtual page 318
.word  26, 0   # the physical page number and the valid flag for virtual page 319
.word  109, 0   # the physical page number and the valid flag for virtual page 320
.word  26, 0   # the physical page number and the valid flag for virtual page 321
.word  18, 0   # the physical page number and the valid flag for virtual page 322
.word  93, 0   # the physical page number and the valid flag for virtual page 323
.word  82, 0   # the physical page number and the valid flag for virtual page 324
.word  37, 0   # the physical page number and the valid flag for virtual page 325
.word  11, 0   # the physical page number and the valid flag for virtual page 326
.word  108, 0   # the physical page number and the valid flag for virtual page 327
.word  124, 0   # the physical page number and the valid flag for virtual page 328
.word  98, 0   # the physical page number and the valid flag for virtual page 329
.word  90, 0   # the physical page number and the valid flag for virtual page 330
.word  35, 0   # the physical page number and the valid flag for virtual page 331
.word  38, 0   # the physical page number and the valid flag for virtual page 332
.word  56, 0   # the physical page number and the valid flag for virtual page 333
.word  35, 0   # the physical page number and the valid flag for virtual page 334
.word  44, 0   # the physical page number and the valid flag for virtual page 335
.word  35, 0   # the physical page number and the valid flag for virtual page 336
.word  57, 0   # the physical page number and the valid flag for virtual page 337
.word  124, 0   # the physical page number and the valid flag for virtual page 338
.word  81, 0   # the physical page number and the valid flag for virtual page 339
.word  102, 0   # the physical page number and the valid flag for virtual page 340
.word  25, 0   # the physical page number and the valid flag for virtual page 341
.word  22, 0   # the physical page number and the valid flag for virtual page 342
.word  14, 0   # the physical page number and the valid flag for virtual page 343
.word  72, 0   # the physical page number and the valid flag for virtual page 344
.word  101, 0   # the physical page number and the valid flag for virtual page 345
.word  32, 0   # the physical page number and the valid flag for virtual page 346
.word  107, 0   # the physical page number and the valid flag for virtual page 347
.word  6, 0   # the physical page number and the valid flag for virtual page 348
.word  113, 0   # the physical page number and the valid flag for virtual page 349
.word  104, 0   # the physical page number and the valid flag for virtual page 350
.word  9, 0   # the physical page number and the valid flag for virtual page 351
.word  9, 0   # the physical page number and the valid flag for virtual page 352
.word  19, 0   # the physical page number and the valid flag for virtual page 353
.word  68, 0   # the physical page number and the valid flag for virtual page 354
.word  122, 0   # the physical page number and the valid flag for virtual page 355
.word  107, 0   # the physical page number and the valid flag for virtual page 356
.word  14, 0   # the physical page number and the valid flag for virtual page 357
.word  48, 0   # the physical page number and the valid flag for virtual page 358
.word  85, 0   # the physical page number and the valid flag for virtual page 359
.word  54, 0   # the physical page number and the valid flag for virtual page 360
.word  81, 0   # the physical page number and the valid flag for virtual page 361
.word  56, 0   # the physical page number and the valid flag for virtual page 362
.word  10, 0   # the physical page number and the valid flag for virtual page 363
.word  111, 0   # the physical page number and the valid flag for virtual page 364
.word  98, 0   # the physical page number and the valid flag for virtual page 365
.word  25, 0   # the physical page number and the valid flag for virtual page 366
.word  116, 0   # the physical page number and the valid flag for virtual page 367
.word  83, 0   # the physical page number and the valid flag for virtual page 368
.word  21, 0   # the physical page number and the valid flag for virtual page 369
.word  35, 0   # the physical page number and the valid flag for virtual page 370
.word  45, 0   # the physical page number and the valid flag for virtual page 371
.word  96, 0   # the physical page number and the valid flag for virtual page 372
.word  1, 0   # the physical page number and the valid flag for virtual page 373
.word  97, 0   # the physical page number and the valid flag for virtual page 374
.word  38, 0   # the physical page number and the valid flag for virtual page 375
.word  23, 0   # the physical page number and the valid flag for virtual page 376
.word  52, 0   # the physical page number and the valid flag for virtual page 377
.word  124, 0   # the physical page number and the valid flag for virtual page 378
.word  119, 0   # the physical page number and the valid flag for virtual page 379
.word  1, 0   # the physical page number and the valid flag for virtual page 380
.word  38, 0   # the physical page number and the valid flag for virtual page 381
.word  93, 0   # the physical page number and the valid flag for virtual page 382
.word  115, 0   # the physical page number and the valid flag for virtual page 383
.word  112, 0   # the physical page number and the valid flag for virtual page 384
.word  108, 0   # the physical page number and the valid flag for virtual page 385
.word  18, 0   # the physical page number and the valid flag for virtual page 386
.word  0, 0   # the physical page number and the valid flag for virtual page 387
.word  7, 0   # the physical page number and the valid flag for virtual page 388
.word  46, 0   # the physical page number and the valid flag for virtual page 389
.word  115, 0   # the physical page number and the valid flag for virtual page 390
.word  38, 0   # the physical page number and the valid flag for virtual page 391
.word  124, 0   # the physical page number and the valid flag for virtual page 392
.word  91, 0   # the physical page number and the valid flag for virtual page 393
.word  5, 0   # the physical page number and the valid flag for virtual page 394
.word  101, 0   # the physical page number and the valid flag for virtual page 395
.word  29, 0   # the physical page number and the valid flag for virtual page 396
.word  27, 0   # the physical page number and the valid flag for virtual page 397
.word  30, 0   # the physical page number and the valid flag for virtual page 398
.word  76, 0   # the physical page number and the valid flag for virtual page 399
.word  17, 0   # the physical page number and the valid flag for virtual page 400
.word  6, 0   # the physical page number and the valid flag for virtual page 401
.word  74, 0   # the physical page number and the valid flag for virtual page 402
.word  71, 0   # the physical page number and the valid flag for virtual page 403
.word  97, 0   # the physical page number and the valid flag for virtual page 404
.word  19, 0   # the physical page number and the valid flag for virtual page 405
.word  110, 0   # the physical page number and the valid flag for virtual page 406
.word  57, 0   # the physical page number and the valid flag for virtual page 407
.word  55, 0   # the physical page number and the valid flag for virtual page 408
.word  83, 0   # the physical page number and the valid flag for virtual page 409
.word  43, 0   # the physical page number and the valid flag for virtual page 410
.word  74, 0   # the physical page number and the valid flag for virtual page 411
.word  101, 0   # the physical page number and the valid flag for virtual page 412
.word  95, 0   # the physical page number and the valid flag for virtual page 413
.word  5, 0   # the physical page number and the valid flag for virtual page 414
.word  3, 0   # the physical page number and the valid flag for virtual page 415
.word  40, 0   # the physical page number and the valid flag for virtual page 416
.word  15, 0   # the physical page number and the valid flag for virtual page 417
.word  69, 0   # the physical page number and the valid flag for virtual page 418
.word  24, 0   # the physical page number and the valid flag for virtual page 419
.word  46, 0   # the physical page number and the valid flag for virtual page 420
.word  108, 0   # the physical page number and the valid flag for virtual page 421
.word  27, 0   # the physical page number and the valid flag for virtual page 422
.word  4, 0   # the physical page number and the valid flag for virtual page 423
.word  87, 0   # the physical page number and the valid flag for virtual page 424
.word  104, 0   # the physical page number and the valid flag for virtual page 425
.word  8, 0   # the physical page number and the valid flag for virtual page 426
.word  91, 0   # the physical page number and the valid flag for virtual page 427
.word  57, 0   # the physical page number and the valid flag for virtual page 428
.word  77, 0   # the physical page number and the valid flag for virtual page 429
.word  123, 0   # the physical page number and the valid flag for virtual page 430
.word  92, 0   # the physical page number and the valid flag for virtual page 431
.word  102, 0   # the physical page number and the valid flag for virtual page 432
.word  116, 0   # the physical page number and the valid flag for virtual page 433
.word  59, 0   # the physical page number and the valid flag for virtual page 434
.word  70, 0   # the physical page number and the valid flag for virtual page 435
.word  113, 0   # the physical page number and the valid flag for virtual page 436
.word  55, 0   # the physical page number and the valid flag for virtual page 437
.word  4, 0   # the physical page number and the valid flag for virtual page 438
.word  110, 0   # the physical page number and the valid flag for virtual page 439
.word  46, 0   # the physical page number and the valid flag for virtual page 440
.word  40, 0   # the physical page number and the valid flag for virtual page 441
.word  117, 0   # the physical page number and the valid flag for virtual page 442
.word  13, 0   # the physical page number and the valid flag for virtual page 443
.word  58, 0   # the physical page number and the valid flag for virtual page 444
.word  4, 0   # the physical page number and the valid flag for virtual page 445
.word  42, 0   # the physical page number and the valid flag for virtual page 446
.word  94, 0   # the physical page number and the valid flag for virtual page 447
.word  59, 0   # the physical page number and the valid flag for virtual page 448
.word  98, 0   # the physical page number and the valid flag for virtual page 449
.word  37, 0   # the physical page number and the valid flag for virtual page 450
.word  105, 0   # the physical page number and the valid flag for virtual page 451
.word  105, 0   # the physical page number and the valid flag for virtual page 452
.word  48, 0   # the physical page number and the valid flag for virtual page 453
.word  114, 0   # the physical page number and the valid flag for virtual page 454
.word  25, 0   # the physical page number and the valid flag for virtual page 455
.word  78, 0   # the physical page number and the valid flag for virtual page 456
.word  96, 0   # the physical page number and the valid flag for virtual page 457
.word  10, 0   # the physical page number and the valid flag for virtual page 458
.word  21, 0   # the physical page number and the valid flag for virtual page 459
.word  73, 0   # the physical page number and the valid flag for virtual page 460
.word  95, 0   # the physical page number and the valid flag for virtual page 461
.word  121, 0   # the physical page number and the valid flag for virtual page 462
.word  77, 0   # the physical page number and the valid flag for virtual page 463
.word  89, 0   # the physical page number and the valid flag for virtual page 464
.word  71, 0   # the physical page number and the valid flag for virtual page 465
.word  60, 0   # the physical page number and the valid flag for virtual page 466
.word  83, 0   # the physical page number and the valid flag for virtual page 467
.word  24, 0   # the physical page number and the valid flag for virtual page 468
.word  85, 0   # the physical page number and the valid flag for virtual page 469
.word  109, 0   # the physical page number and the valid flag for virtual page 470
.word  109, 0   # the physical page number and the valid flag for virtual page 471
.word  6, 0   # the physical page number and the valid flag for virtual page 472
.word  29, 0   # the physical page number and the valid flag for virtual page 473
.word  34, 0   # the physical page number and the valid flag for virtual page 474
.word  104, 0   # the physical page number and the valid flag for virtual page 475
.word  8, 0   # the physical page number and the valid flag for virtual page 476
.word  124, 0   # the physical page number and the valid flag for virtual page 477
.word  18, 0   # the physical page number and the valid flag for virtual page 478
.word  47, 0   # the physical page number and the valid flag for virtual page 479
.word  49, 0   # the physical page number and the valid flag for virtual page 480
.word  79, 0   # the physical page number and the valid flag for virtual page 481
.word  121, 0   # the physical page number and the valid flag for virtual page 482
.word  28, 0   # the physical page number and the valid flag for virtual page 483
.word  63, 0   # the physical page number and the valid flag for virtual page 484
.word  98, 0   # the physical page number and the valid flag for virtual page 485
.word  62, 0   # the physical page number and the valid flag for virtual page 486
.word  13, 0   # the physical page number and the valid flag for virtual page 487
.word  105, 0   # the physical page number and the valid flag for virtual page 488
.word  44, 0   # the physical page number and the valid flag for virtual page 489
.word  83, 0   # the physical page number and the valid flag for virtual page 490
.word  59, 0   # the physical page number and the valid flag for virtual page 491
.word  88, 0   # the physical page number and the valid flag for virtual page 492
.word  57, 0   # the physical page number and the valid flag for virtual page 493
.word  94, 0   # the physical page number and the valid flag for virtual page 494
.word  71, 0   # the physical page number and the valid flag for virtual page 495
.word  115, 0   # the physical page number and the valid flag for virtual page 496
.word  103, 0   # the physical page number and the valid flag for virtual page 497
.word  22, 0   # the physical page number and the valid flag for virtual page 498
.word  22, 0   # the physical page number and the valid flag for virtual page 499
.word  95, 0   # the physical page number and the valid flag for virtual page 500
.word  85, 0   # the physical page number and the valid flag for virtual page 501
.word  111, 0   # the physical page number and the valid flag for virtual page 502
.word  95, 0   # the physical page number and the valid flag for virtual page 503
.word  70, 0   # the physical page number and the valid flag for virtual page 504
.word  25, 0   # the physical page number and the valid flag for virtual page 505
.word  121, 0   # the physical page number and the valid flag for virtual page 506
.word  2, 0   # the physical page number and the valid flag for virtual page 507
.word  88, 0   # the physical page number and the valid flag for virtual page 508
.word  49, 0   # the physical page number and the valid flag for virtual page 509
.word  5, 0   # the physical page number and the valid flag for virtual page 510
.word  28, 0   # the physical page number and the valid flag for virtual page 511
.word  16, 0   # the physical page number and the valid flag for virtual page 512
.word  60, 0   # the physical page number and the valid flag for virtual page 513
.word  11, 0   # the physical page number and the valid flag for virtual page 514
.word  88, 0   # the physical page number and the valid flag for virtual page 515
.word  57, 0   # the physical page number and the valid flag for virtual page 516
.word  107, 0   # the physical page number and the valid flag for virtual page 517
.word  72, 0   # the physical page number and the valid flag for virtual page 518
.word  8, 0   # the physical page number and the valid flag for virtual page 519
.word  48, 0   # the physical page number and the valid flag for virtual page 520
.word  50, 0   # the physical page number and the valid flag for virtual page 521
.word  43, 0   # the physical page number and the valid flag for virtual page 522
.word  116, 0   # the physical page number and the valid flag for virtual page 523
.word  107, 0   # the physical page number and the valid flag for virtual page 524
.word  67, 0   # the physical page number and the valid flag for virtual page 525
.word  114, 0   # the physical page number and the valid flag for virtual page 526
.word  113, 0   # the physical page number and the valid flag for virtual page 527
.word  58, 0   # the physical page number and the valid flag for virtual page 528
.word  60, 0   # the physical page number and the valid flag for virtual page 529
.word  17, 0   # the physical page number and the valid flag for virtual page 530
.word  54, 0   # the physical page number and the valid flag for virtual page 531
.word  77, 0   # the physical page number and the valid flag for virtual page 532
.word  31, 0   # the physical page number and the valid flag for virtual page 533
.word  83, 0   # the physical page number and the valid flag for virtual page 534
.word  108, 0   # the physical page number and the valid flag for virtual page 535
.word  119, 0   # the physical page number and the valid flag for virtual page 536
.word  4, 0   # the physical page number and the valid flag for virtual page 537
.word  67, 0   # the physical page number and the valid flag for virtual page 538
.word  4, 0   # the physical page number and the valid flag for virtual page 539
.word  49, 0   # the physical page number and the valid flag for virtual page 540
.word  10, 0   # the physical page number and the valid flag for virtual page 541
.word  77, 0   # the physical page number and the valid flag for virtual page 542
.word  77, 0   # the physical page number and the valid flag for virtual page 543
.word  98, 0   # the physical page number and the valid flag for virtual page 544
.word  19, 0   # the physical page number and the valid flag for virtual page 545
.word  33, 0   # the physical page number and the valid flag for virtual page 546
.word  70, 0   # the physical page number and the valid flag for virtual page 547
.word  94, 0   # the physical page number and the valid flag for virtual page 548
.word  49, 0   # the physical page number and the valid flag for virtual page 549
.word  88, 0   # the physical page number and the valid flag for virtual page 550
.word  49, 0   # the physical page number and the valid flag for virtual page 551
.word  44, 0   # the physical page number and the valid flag for virtual page 552
.word  91, 0   # the physical page number and the valid flag for virtual page 553
.word  90, 0   # the physical page number and the valid flag for virtual page 554
.word  104, 0   # the physical page number and the valid flag for virtual page 555
.word  12, 0   # the physical page number and the valid flag for virtual page 556
.word  101, 0   # the physical page number and the valid flag for virtual page 557
.word  127, 0   # the physical page number and the valid flag for virtual page 558
.word  116, 0   # the physical page number and the valid flag for virtual page 559
.word  56, 0   # the physical page number and the valid flag for virtual page 560
.word  47, 0   # the physical page number and the valid flag for virtual page 561
.word  116, 0   # the physical page number and the valid flag for virtual page 562
.word  92, 0   # the physical page number and the valid flag for virtual page 563
.word  107, 0   # the physical page number and the valid flag for virtual page 564
.word  28, 0   # the physical page number and the valid flag for virtual page 565
.word  97, 0   # the physical page number and the valid flag for virtual page 566
.word  59, 0   # the physical page number and the valid flag for virtual page 567
.word  32, 0   # the physical page number and the valid flag for virtual page 568
.word  69, 0   # the physical page number and the valid flag for virtual page 569
.word  72, 0   # the physical page number and the valid flag for virtual page 570
.word  21, 0   # the physical page number and the valid flag for virtual page 571
.word  28, 0   # the physical page number and the valid flag for virtual page 572
.word  111, 0   # the physical page number and the valid flag for virtual page 573
.word  49, 0   # the physical page number and the valid flag for virtual page 574
.word  107, 0   # the physical page number and the valid flag for virtual page 575
.word  46, 0   # the physical page number and the valid flag for virtual page 576
.word  59, 0   # the physical page number and the valid flag for virtual page 577
.word  4, 0   # the physical page number and the valid flag for virtual page 578
.word  13, 0   # the physical page number and the valid flag for virtual page 579
.word  54, 0   # the physical page number and the valid flag for virtual page 580
.word  29, 0   # the physical page number and the valid flag for virtual page 581
.word  54, 0   # the physical page number and the valid flag for virtual page 582
.word  48, 0   # the physical page number and the valid flag for virtual page 583
.word  100, 0   # the physical page number and the valid flag for virtual page 584
.word  15, 0   # the physical page number and the valid flag for virtual page 585
.word  39, 0   # the physical page number and the valid flag for virtual page 586
.word  64, 0   # the physical page number and the valid flag for virtual page 587
.word  66, 0   # the physical page number and the valid flag for virtual page 588
.word  7, 0   # the physical page number and the valid flag for virtual page 589
.word  75, 0   # the physical page number and the valid flag for virtual page 590
.word  120, 0   # the physical page number and the valid flag for virtual page 591
.word  117, 0   # the physical page number and the valid flag for virtual page 592
.word  38, 0   # the physical page number and the valid flag for virtual page 593
.word  9, 0   # the physical page number and the valid flag for virtual page 594
.word  47, 0   # the physical page number and the valid flag for virtual page 595
.word  64, 0   # the physical page number and the valid flag for virtual page 596
.word  50, 0   # the physical page number and the valid flag for virtual page 597
.word  96, 0   # the physical page number and the valid flag for virtual page 598
.word  117, 0   # the physical page number and the valid flag for virtual page 599
.word  73, 0   # the physical page number and the valid flag for virtual page 600
.word  70, 0   # the physical page number and the valid flag for virtual page 601
.word  80, 0   # the physical page number and the valid flag for virtual page 602
.word  94, 0   # the physical page number and the valid flag for virtual page 603
.word  32, 0   # the physical page number and the valid flag for virtual page 604
.word  72, 0   # the physical page number and the valid flag for virtual page 605
.word  120, 0   # the physical page number and the valid flag for virtual page 606
.word  30, 0   # the physical page number and the valid flag for virtual page 607
.word  125, 0   # the physical page number and the valid flag for virtual page 608
.word  28, 0   # the physical page number and the valid flag for virtual page 609
.word  124, 0   # the physical page number and the valid flag for virtual page 610
.word  86, 0   # the physical page number and the valid flag for virtual page 611
.word  73, 0   # the physical page number and the valid flag for virtual page 612
.word  23, 0   # the physical page number and the valid flag for virtual page 613
.word  41, 0   # the physical page number and the valid flag for virtual page 614
.word  46, 0   # the physical page number and the valid flag for virtual page 615
.word  96, 0   # the physical page number and the valid flag for virtual page 616
.word  55, 0   # the physical page number and the valid flag for virtual page 617
.word  92, 0   # the physical page number and the valid flag for virtual page 618
.word  36, 0   # the physical page number and the valid flag for virtual page 619
.word  22, 0   # the physical page number and the valid flag for virtual page 620
.word  17, 0   # the physical page number and the valid flag for virtual page 621
.word  31, 0   # the physical page number and the valid flag for virtual page 622
.word  36, 0   # the physical page number and the valid flag for virtual page 623
.word  120, 0   # the physical page number and the valid flag for virtual page 624
.word  10, 0   # the physical page number and the valid flag for virtual page 625
.word  22, 0   # the physical page number and the valid flag for virtual page 626
.word  88, 0   # the physical page number and the valid flag for virtual page 627
.word  84, 0   # the physical page number and the valid flag for virtual page 628
.word  74, 0   # the physical page number and the valid flag for virtual page 629
.word  26, 0   # the physical page number and the valid flag for virtual page 630
.word  65, 0   # the physical page number and the valid flag for virtual page 631
.word  123, 0   # the physical page number and the valid flag for virtual page 632
.word  110, 0   # the physical page number and the valid flag for virtual page 633
.word  35, 0   # the physical page number and the valid flag for virtual page 634
.word  7, 0   # the physical page number and the valid flag for virtual page 635
.word  69, 0   # the physical page number and the valid flag for virtual page 636
.word  125, 0   # the physical page number and the valid flag for virtual page 637
.word  107, 0   # the physical page number and the valid flag for virtual page 638
.word  13, 0   # the physical page number and the valid flag for virtual page 639
.word  86, 0   # the physical page number and the valid flag for virtual page 640
.word  30, 0   # the physical page number and the valid flag for virtual page 641
.word  80, 0   # the physical page number and the valid flag for virtual page 642
.word  73, 0   # the physical page number and the valid flag for virtual page 643
.word  32, 0   # the physical page number and the valid flag for virtual page 644
.word  8, 0   # the physical page number and the valid flag for virtual page 645
.word  122, 0   # the physical page number and the valid flag for virtual page 646
.word  83, 0   # the physical page number and the valid flag for virtual page 647
.word  41, 0   # the physical page number and the valid flag for virtual page 648
.word  57, 0   # the physical page number and the valid flag for virtual page 649
.word  63, 0   # the physical page number and the valid flag for virtual page 650
.word  59, 0   # the physical page number and the valid flag for virtual page 651
.word  14, 0   # the physical page number and the valid flag for virtual page 652
.word  107, 0   # the physical page number and the valid flag for virtual page 653
.word  67, 0   # the physical page number and the valid flag for virtual page 654
.word  32, 0   # the physical page number and the valid flag for virtual page 655
.word  73, 0   # the physical page number and the valid flag for virtual page 656
.word  68, 0   # the physical page number and the valid flag for virtual page 657
.word  100, 0   # the physical page number and the valid flag for virtual page 658
.word  126, 0   # the physical page number and the valid flag for virtual page 659
.word  47, 0   # the physical page number and the valid flag for virtual page 660
.word  77, 0   # the physical page number and the valid flag for virtual page 661
.word  85, 0   # the physical page number and the valid flag for virtual page 662
.word  72, 0   # the physical page number and the valid flag for virtual page 663
.word  60, 0   # the physical page number and the valid flag for virtual page 664
.word  37, 0   # the physical page number and the valid flag for virtual page 665
.word  8, 0   # the physical page number and the valid flag for virtual page 666
.word  55, 0   # the physical page number and the valid flag for virtual page 667
.word  19, 0   # the physical page number and the valid flag for virtual page 668
.word  119, 0   # the physical page number and the valid flag for virtual page 669
.word  82, 0   # the physical page number and the valid flag for virtual page 670
.word  97, 0   # the physical page number and the valid flag for virtual page 671
.word  65, 0   # the physical page number and the valid flag for virtual page 672
.word  41, 0   # the physical page number and the valid flag for virtual page 673
.word  74, 0   # the physical page number and the valid flag for virtual page 674
.word  13, 0   # the physical page number and the valid flag for virtual page 675
.word  66, 0   # the physical page number and the valid flag for virtual page 676
.word  86, 0   # the physical page number and the valid flag for virtual page 677
.word  114, 0   # the physical page number and the valid flag for virtual page 678
.word  70, 0   # the physical page number and the valid flag for virtual page 679
.word  70, 0   # the physical page number and the valid flag for virtual page 680
.word  127, 0   # the physical page number and the valid flag for virtual page 681
.word  25, 0   # the physical page number and the valid flag for virtual page 682
.word  46, 0   # the physical page number and the valid flag for virtual page 683
.word  53, 0   # the physical page number and the valid flag for virtual page 684
.word  125, 0   # the physical page number and the valid flag for virtual page 685
.word  127, 0   # the physical page number and the valid flag for virtual page 686
.word  21, 0   # the physical page number and the valid flag for virtual page 687
.word  112, 0   # the physical page number and the valid flag for virtual page 688
.word  58, 0   # the physical page number and the valid flag for virtual page 689
.word  59, 0   # the physical page number and the valid flag for virtual page 690
.word  74, 0   # the physical page number and the valid flag for virtual page 691
.word  90, 0   # the physical page number and the valid flag for virtual page 692
.word  33, 0   # the physical page number and the valid flag for virtual page 693
.word  90, 0   # the physical page number and the valid flag for virtual page 694
.word  49, 0   # the physical page number and the valid flag for virtual page 695
.word  23, 0   # the physical page number and the valid flag for virtual page 696
.word  83, 0   # the physical page number and the valid flag for virtual page 697
.word  73, 0   # the physical page number and the valid flag for virtual page 698
.word  22, 0   # the physical page number and the valid flag for virtual page 699
.word  19, 0   # the physical page number and the valid flag for virtual page 700
.word  28, 0   # the physical page number and the valid flag for virtual page 701
.word  117, 0   # the physical page number and the valid flag for virtual page 702
.word  65, 0   # the physical page number and the valid flag for virtual page 703
.word  70, 0   # the physical page number and the valid flag for virtual page 704
.word  37, 0   # the physical page number and the valid flag for virtual page 705
.word  48, 0   # the physical page number and the valid flag for virtual page 706
.word  75, 0   # the physical page number and the valid flag for virtual page 707
.word  55, 0   # the physical page number and the valid flag for virtual page 708
.word  107, 0   # the physical page number and the valid flag for virtual page 709
.word  87, 0   # the physical page number and the valid flag for virtual page 710
.word  48, 0   # the physical page number and the valid flag for virtual page 711
.word  63, 0   # the physical page number and the valid flag for virtual page 712
.word  111, 0   # the physical page number and the valid flag for virtual page 713
.word  49, 0   # the physical page number and the valid flag for virtual page 714
.word  36, 0   # the physical page number and the valid flag for virtual page 715
.word  16, 0   # the physical page number and the valid flag for virtual page 716
.word  48, 0   # the physical page number and the valid flag for virtual page 717
.word  27, 0   # the physical page number and the valid flag for virtual page 718
.word  43, 0   # the physical page number and the valid flag for virtual page 719
.word  117, 0   # the physical page number and the valid flag for virtual page 720
.word  86, 0   # the physical page number and the valid flag for virtual page 721
.word  98, 0   # the physical page number and the valid flag for virtual page 722
.word  100, 0   # the physical page number and the valid flag for virtual page 723
.word  92, 0   # the physical page number and the valid flag for virtual page 724
.word  48, 0   # the physical page number and the valid flag for virtual page 725
.word  113, 0   # the physical page number and the valid flag for virtual page 726
.word  37, 0   # the physical page number and the valid flag for virtual page 727
.word  17, 0   # the physical page number and the valid flag for virtual page 728
.word  96, 0   # the physical page number and the valid flag for virtual page 729
.word  44, 0   # the physical page number and the valid flag for virtual page 730
.word  77, 0   # the physical page number and the valid flag for virtual page 731
.word  76, 0   # the physical page number and the valid flag for virtual page 732
.word  85, 0   # the physical page number and the valid flag for virtual page 733
.word  27, 0   # the physical page number and the valid flag for virtual page 734
.word  86, 0   # the physical page number and the valid flag for virtual page 735
.word  110, 0   # the physical page number and the valid flag for virtual page 736
.word  122, 0   # the physical page number and the valid flag for virtual page 737
.word  75, 0   # the physical page number and the valid flag for virtual page 738
.word  42, 0   # the physical page number and the valid flag for virtual page 739
.word  8, 0   # the physical page number and the valid flag for virtual page 740
.word  45, 0   # the physical page number and the valid flag for virtual page 741
.word  113, 0   # the physical page number and the valid flag for virtual page 742
.word  56, 0   # the physical page number and the valid flag for virtual page 743
.word  29, 0   # the physical page number and the valid flag for virtual page 744
.word  115, 0   # the physical page number and the valid flag for virtual page 745
.word  81, 0   # the physical page number and the valid flag for virtual page 746
.word  70, 0   # the physical page number and the valid flag for virtual page 747
.word  41, 0   # the physical page number and the valid flag for virtual page 748
.word  106, 0   # the physical page number and the valid flag for virtual page 749
.word  94, 0   # the physical page number and the valid flag for virtual page 750
.word  9, 0   # the physical page number and the valid flag for virtual page 751
.word  97, 0   # the physical page number and the valid flag for virtual page 752
.word  127, 0   # the physical page number and the valid flag for virtual page 753
.word  35, 0   # the physical page number and the valid flag for virtual page 754
.word  115, 0   # the physical page number and the valid flag for virtual page 755
.word  61, 0   # the physical page number and the valid flag for virtual page 756
.word  96, 0   # the physical page number and the valid flag for virtual page 757
.word  97, 0   # the physical page number and the valid flag for virtual page 758
.word  76, 0   # the physical page number and the valid flag for virtual page 759
.word  52, 0   # the physical page number and the valid flag for virtual page 760
.word  53, 0   # the physical page number and the valid flag for virtual page 761
.word  122, 0   # the physical page number and the valid flag for virtual page 762
.word  4, 0   # the physical page number and the valid flag for virtual page 763
.word  70, 0   # the physical page number and the valid flag for virtual page 764
.word  11, 0   # the physical page number and the valid flag for virtual page 765
.word  13, 0   # the physical page number and the valid flag for virtual page 766
.word  72, 0   # the physical page number and the valid flag for virtual page 767
.word  64, 0   # the physical page number and the valid flag for virtual page 768
.word  16, 0   # the physical page number and the valid flag for virtual page 769
.word  99, 0   # the physical page number and the valid flag for virtual page 770
.word  83, 0   # the physical page number and the valid flag for virtual page 771
.word  60, 0   # the physical page number and the valid flag for virtual page 772
.word  6, 0   # the physical page number and the valid flag for virtual page 773
.word  10, 0   # the physical page number and the valid flag for virtual page 774
.word  7, 0   # the physical page number and the valid flag for virtual page 775
.word  103, 0   # the physical page number and the valid flag for virtual page 776
.word  114, 0   # the physical page number and the valid flag for virtual page 777
.word  63, 0   # the physical page number and the valid flag for virtual page 778
.word  60, 0   # the physical page number and the valid flag for virtual page 779
.word  7, 0   # the physical page number and the valid flag for virtual page 780
.word  20, 0   # the physical page number and the valid flag for virtual page 781
.word  18, 0   # the physical page number and the valid flag for virtual page 782
.word  88, 0   # the physical page number and the valid flag for virtual page 783
.word  60, 0   # the physical page number and the valid flag for virtual page 784
.word  28, 0   # the physical page number and the valid flag for virtual page 785
.word  68, 0   # the physical page number and the valid flag for virtual page 786
.word  31, 0   # the physical page number and the valid flag for virtual page 787
.word  5, 0   # the physical page number and the valid flag for virtual page 788
.word  27, 0   # the physical page number and the valid flag for virtual page 789
.word  116, 0   # the physical page number and the valid flag for virtual page 790
.word  77, 0   # the physical page number and the valid flag for virtual page 791
.word  7, 0   # the physical page number and the valid flag for virtual page 792
.word  56, 0   # the physical page number and the valid flag for virtual page 793
.word  122, 0   # the physical page number and the valid flag for virtual page 794
.word  98, 0   # the physical page number and the valid flag for virtual page 795
.word  10, 0   # the physical page number and the valid flag for virtual page 796
.word  36, 0   # the physical page number and the valid flag for virtual page 797
.word  20, 0   # the physical page number and the valid flag for virtual page 798
.word  62, 0   # the physical page number and the valid flag for virtual page 799
.word  69, 0   # the physical page number and the valid flag for virtual page 800
.word  80, 0   # the physical page number and the valid flag for virtual page 801
.word  64, 0   # the physical page number and the valid flag for virtual page 802
.word  109, 0   # the physical page number and the valid flag for virtual page 803
.word  91, 0   # the physical page number and the valid flag for virtual page 804
.word  93, 0   # the physical page number and the valid flag for virtual page 805
.word  104, 0   # the physical page number and the valid flag for virtual page 806
.word  68, 0   # the physical page number and the valid flag for virtual page 807
.word  37, 0   # the physical page number and the valid flag for virtual page 808
.word  84, 0   # the physical page number and the valid flag for virtual page 809
.word  68, 0   # the physical page number and the valid flag for virtual page 810
.word  45, 0   # the physical page number and the valid flag for virtual page 811
.word  50, 0   # the physical page number and the valid flag for virtual page 812
.word  23, 0   # the physical page number and the valid flag for virtual page 813
.word  125, 0   # the physical page number and the valid flag for virtual page 814
.word  63, 0   # the physical page number and the valid flag for virtual page 815
.word  12, 0   # the physical page number and the valid flag for virtual page 816
.word  23, 0   # the physical page number and the valid flag for virtual page 817
.word  14, 0   # the physical page number and the valid flag for virtual page 818
.word  18, 0   # the physical page number and the valid flag for virtual page 819
.word  61, 0   # the physical page number and the valid flag for virtual page 820
.word  72, 0   # the physical page number and the valid flag for virtual page 821
.word  112, 0   # the physical page number and the valid flag for virtual page 822
.word  81, 0   # the physical page number and the valid flag for virtual page 823
.word  18, 0   # the physical page number and the valid flag for virtual page 824
.word  82, 0   # the physical page number and the valid flag for virtual page 825
.word  118, 0   # the physical page number and the valid flag for virtual page 826
.word  16, 0   # the physical page number and the valid flag for virtual page 827
.word  31, 0   # the physical page number and the valid flag for virtual page 828
.word  10, 0   # the physical page number and the valid flag for virtual page 829
.word  118, 0   # the physical page number and the valid flag for virtual page 830
.word  96, 0   # the physical page number and the valid flag for virtual page 831
.word  3, 0   # the physical page number and the valid flag for virtual page 832
.word  32, 0   # the physical page number and the valid flag for virtual page 833
.word  41, 0   # the physical page number and the valid flag for virtual page 834
.word  33, 0   # the physical page number and the valid flag for virtual page 835
.word  110, 0   # the physical page number and the valid flag for virtual page 836
.word  25, 0   # the physical page number and the valid flag for virtual page 837
.word  84, 0   # the physical page number and the valid flag for virtual page 838
.word  24, 0   # the physical page number and the valid flag for virtual page 839
.word  96, 0   # the physical page number and the valid flag for virtual page 840
.word  0, 0   # the physical page number and the valid flag for virtual page 841
.word  40, 0   # the physical page number and the valid flag for virtual page 842
.word  66, 0   # the physical page number and the valid flag for virtual page 843
.word  51, 0   # the physical page number and the valid flag for virtual page 844
.word  89, 0   # the physical page number and the valid flag for virtual page 845
.word  103, 0   # the physical page number and the valid flag for virtual page 846
.word  103, 0   # the physical page number and the valid flag for virtual page 847
.word  91, 0   # the physical page number and the valid flag for virtual page 848
.word  87, 0   # the physical page number and the valid flag for virtual page 849
.word  73, 0   # the physical page number and the valid flag for virtual page 850
.word  113, 0   # the physical page number and the valid flag for virtual page 851
.word  109, 0   # the physical page number and the valid flag for virtual page 852
.word  79, 0   # the physical page number and the valid flag for virtual page 853
.word  30, 0   # the physical page number and the valid flag for virtual page 854
.word  127, 0   # the physical page number and the valid flag for virtual page 855
.word  94, 0   # the physical page number and the valid flag for virtual page 856
.word  107, 0   # the physical page number and the valid flag for virtual page 857
.word  52, 0   # the physical page number and the valid flag for virtual page 858
.word  54, 0   # the physical page number and the valid flag for virtual page 859
.word  13, 0   # the physical page number and the valid flag for virtual page 860
.word  35, 0   # the physical page number and the valid flag for virtual page 861
.word  123, 0   # the physical page number and the valid flag for virtual page 862
.word  87, 0   # the physical page number and the valid flag for virtual page 863
.word  4, 0   # the physical page number and the valid flag for virtual page 864
.word  105, 0   # the physical page number and the valid flag for virtual page 865
.word  103, 0   # the physical page number and the valid flag for virtual page 866
.word  23, 0   # the physical page number and the valid flag for virtual page 867
.word  123, 0   # the physical page number and the valid flag for virtual page 868
.word  36, 0   # the physical page number and the valid flag for virtual page 869
.word  22, 0   # the physical page number and the valid flag for virtual page 870
.word  43, 0   # the physical page number and the valid flag for virtual page 871
.word  30, 0   # the physical page number and the valid flag for virtual page 872
.word  96, 0   # the physical page number and the valid flag for virtual page 873
.word  51, 0   # the physical page number and the valid flag for virtual page 874
.word  34, 0   # the physical page number and the valid flag for virtual page 875
.word  17, 0   # the physical page number and the valid flag for virtual page 876
.word  68, 0   # the physical page number and the valid flag for virtual page 877
.word  26, 0   # the physical page number and the valid flag for virtual page 878
.word  119, 0   # the physical page number and the valid flag for virtual page 879
.word  48, 0   # the physical page number and the valid flag for virtual page 880
.word  68, 0   # the physical page number and the valid flag for virtual page 881
.word  61, 0   # the physical page number and the valid flag for virtual page 882
.word  103, 0   # the physical page number and the valid flag for virtual page 883
.word  27, 0   # the physical page number and the valid flag for virtual page 884
.word  24, 0   # the physical page number and the valid flag for virtual page 885
.word  70, 0   # the physical page number and the valid flag for virtual page 886
.word  0, 0   # the physical page number and the valid flag for virtual page 887
.word  114, 0   # the physical page number and the valid flag for virtual page 888
.word  108, 0   # the physical page number and the valid flag for virtual page 889
.word  126, 0   # the physical page number and the valid flag for virtual page 890
.word  123, 0   # the physical page number and the valid flag for virtual page 891
.word  93, 0   # the physical page number and the valid flag for virtual page 892
.word  89, 0   # the physical page number and the valid flag for virtual page 893
.word  109, 0   # the physical page number and the valid flag for virtual page 894
.word  75, 0   # the physical page number and the valid flag for virtual page 895
.word  80, 0   # the physical page number and the valid flag for virtual page 896
.word  20, 0   # the physical page number and the valid flag for virtual page 897
.word  67, 0   # the physical page number and the valid flag for virtual page 898
.word  118, 0   # the physical page number and the valid flag for virtual page 899
.word  13, 0   # the physical page number and the valid flag for virtual page 900
.word  101, 0   # the physical page number and the valid flag for virtual page 901
.word  118, 0   # the physical page number and the valid flag for virtual page 902
.word  36, 0   # the physical page number and the valid flag for virtual page 903
.word  106, 0   # the physical page number and the valid flag for virtual page 904
.word  91, 0   # the physical page number and the valid flag for virtual page 905
.word  45, 0   # the physical page number and the valid flag for virtual page 906
.word  117, 0   # the physical page number and the valid flag for virtual page 907
.word  84, 0   # the physical page number and the valid flag for virtual page 908
.word  63, 0   # the physical page number and the valid flag for virtual page 909
.word  93, 0   # the physical page number and the valid flag for virtual page 910
.word  24, 0   # the physical page number and the valid flag for virtual page 911
.word  20, 0   # the physical page number and the valid flag for virtual page 912
.word  70, 0   # the physical page number and the valid flag for virtual page 913
.word  49, 0   # the physical page number and the valid flag for virtual page 914
.word  26, 0   # the physical page number and the valid flag for virtual page 915
.word  81, 0   # the physical page number and the valid flag for virtual page 916
.word  10, 0   # the physical page number and the valid flag for virtual page 917
.word  48, 0   # the physical page number and the valid flag for virtual page 918
.word  123, 0   # the physical page number and the valid flag for virtual page 919
.word  86, 0   # the physical page number and the valid flag for virtual page 920
.word  59, 0   # the physical page number and the valid flag for virtual page 921
.word  26, 0   # the physical page number and the valid flag for virtual page 922
.word  7, 0   # the physical page number and the valid flag for virtual page 923
.word  22, 0   # the physical page number and the valid flag for virtual page 924
.word  18, 0   # the physical page number and the valid flag for virtual page 925
.word  18, 0   # the physical page number and the valid flag for virtual page 926
.word  99, 0   # the physical page number and the valid flag for virtual page 927
.word  109, 0   # the physical page number and the valid flag for virtual page 928
.word  7, 0   # the physical page number and the valid flag for virtual page 929
.word  2, 0   # the physical page number and the valid flag for virtual page 930
.word  103, 0   # the physical page number and the valid flag for virtual page 931
.word  41, 0   # the physical page number and the valid flag for virtual page 932
.word  68, 0   # the physical page number and the valid flag for virtual page 933
.word  60, 0   # the physical page number and the valid flag for virtual page 934
.word  43, 0   # the physical page number and the valid flag for virtual page 935
.word  73, 0   # the physical page number and the valid flag for virtual page 936
.word  89, 0   # the physical page number and the valid flag for virtual page 937
.word  93, 0   # the physical page number and the valid flag for virtual page 938
.word  101, 0   # the physical page number and the valid flag for virtual page 939
.word  5, 0   # the physical page number and the valid flag for virtual page 940
.word  49, 0   # the physical page number and the valid flag for virtual page 941
.word  119, 0   # the physical page number and the valid flag for virtual page 942
.word  114, 0   # the physical page number and the valid flag for virtual page 943
.word  14, 0   # the physical page number and the valid flag for virtual page 944
.word  69, 0   # the physical page number and the valid flag for virtual page 945
.word  111, 0   # the physical page number and the valid flag for virtual page 946
.word  50, 0   # the physical page number and the valid flag for virtual page 947
.word  22, 0   # the physical page number and the valid flag for virtual page 948
.word  15, 0   # the physical page number and the valid flag for virtual page 949
.word  35, 0   # the physical page number and the valid flag for virtual page 950
.word  25, 0   # the physical page number and the valid flag for virtual page 951
.word  19, 0   # the physical page number and the valid flag for virtual page 952
.word  66, 0   # the physical page number and the valid flag for virtual page 953
.word  80, 0   # the physical page number and the valid flag for virtual page 954
.word  3, 0   # the physical page number and the valid flag for virtual page 955
.word  64, 0   # the physical page number and the valid flag for virtual page 956
.word  56, 0   # the physical page number and the valid flag for virtual page 957
.word  52, 0   # the physical page number and the valid flag for virtual page 958
.word  72, 0   # the physical page number and the valid flag for virtual page 959
.word  101, 0   # the physical page number and the valid flag for virtual page 960
.word  44, 0   # the physical page number and the valid flag for virtual page 961
.word  111, 0   # the physical page number and the valid flag for virtual page 962
.word  17, 0   # the physical page number and the valid flag for virtual page 963
.word  89, 0   # the physical page number and the valid flag for virtual page 964
.word  41, 0   # the physical page number and the valid flag for virtual page 965
.word  47, 0   # the physical page number and the valid flag for virtual page 966
.word  106, 0   # the physical page number and the valid flag for virtual page 967
.word  69, 0   # the physical page number and the valid flag for virtual page 968
.word  66, 0   # the physical page number and the valid flag for virtual page 969
.word  12, 0   # the physical page number and the valid flag for virtual page 970
.word  24, 0   # the physical page number and the valid flag for virtual page 971
.word  42, 0   # the physical page number and the valid flag for virtual page 972
.word  4, 0   # the physical page number and the valid flag for virtual page 973
.word  49, 0   # the physical page number and the valid flag for virtual page 974
.word  44, 0   # the physical page number and the valid flag for virtual page 975
.word  38, 0   # the physical page number and the valid flag for virtual page 976
.word  41, 0   # the physical page number and the valid flag for virtual page 977
.word  61, 0   # the physical page number and the valid flag for virtual page 978
.word  88, 0   # the physical page number and the valid flag for virtual page 979
.word  115, 0   # the physical page number and the valid flag for virtual page 980
.word  14, 0   # the physical page number and the valid flag for virtual page 981
.word  105, 0   # the physical page number and the valid flag for virtual page 982
.word  2, 0   # the physical page number and the valid flag for virtual page 983
.word  48, 0   # the physical page number and the valid flag for virtual page 984
.word  104, 0   # the physical page number and the valid flag for virtual page 985
.word  106, 0   # the physical page number and the valid flag for virtual page 986
.word  23, 0   # the physical page number and the valid flag for virtual page 987
.word  100, 0   # the physical page number and the valid flag for virtual page 988
.word  50, 0   # the physical page number and the valid flag for virtual page 989
.word  25, 0   # the physical page number and the valid flag for virtual page 990
.word  34, 0   # the physical page number and the valid flag for virtual page 991
.word  64, 0   # the physical page number and the valid flag for virtual page 992
.word  106, 0   # the physical page number and the valid flag for virtual page 993
.word  81, 0   # the physical page number and the valid flag for virtual page 994
.word  29, 0   # the physical page number and the valid flag for virtual page 995
.word  36, 0   # the physical page number and the valid flag for virtual page 996
.word  124, 0   # the physical page number and the valid flag for virtual page 997
.word  24, 0   # the physical page number and the valid flag for virtual page 998
.word  6, 0   # the physical page number and the valid flag for virtual page 999
.word  101, 0   # the physical page number and the valid flag for virtual page 1000
.word  127, 0   # the physical page number and the valid flag for virtual page 1001
.word  2, 0   # the physical page number and the valid flag for virtual page 1002
.word  54, 0   # the physical page number and the valid flag for virtual page 1003
.word  78, 0   # the physical page number and the valid flag for virtual page 1004
.word  31, 0   # the physical page number and the valid flag for virtual page 1005
.word  83, 0   # the physical page number and the valid flag for virtual page 1006
.word  111, 0   # the physical page number and the valid flag for virtual page 1007
.word  100, 0   # the physical page number and the valid flag for virtual page 1008
.word  90, 0   # the physical page number and the valid flag for virtual page 1009
.word  100, 0   # the physical page number and the valid flag for virtual page 1010
.word  52, 0   # the physical page number and the valid flag for virtual page 1011
.word  110, 0   # the physical page number and the valid flag for virtual page 1012
.word  112, 0   # the physical page number and the valid flag for virtual page 1013
.word  72, 0   # the physical page number and the valid flag for virtual page 1014
.word  93, 0   # the physical page number and the valid flag for virtual page 1015
.word  53, 0   # the physical page number and the valid flag for virtual page 1016
.word  20, 0   # the physical page number and the valid flag for virtual page 1017
.word  46, 0   # the physical page number and the valid flag for virtual page 1018
.word  106, 0   # the physical page number and the valid flag for virtual page 1019
.word  9, 0   # the physical page number and the valid flag for virtual page 1020
.word  104, 0   # the physical page number and the valid flag for virtual page 1021
.word  9, 0   # the physical page number and the valid flag for virtual page 1022
.word  24, 0   # the physical page number and the valid flag for virtual page 1023

# THE END OF THE VMT ******************************************************************
.text

.globl main

# REGISTER LIST #######################################################################
# $s0: the size of the segment table
# $s1: the size of the VMT
# $s2: the target segment number
# $s3: the target segment offset address
# $s4: the virtual memory page size
# $t0: the base address of the target segment
# $t1: the limit (the size) of the target segment
# $t2: the target (linear) virtual memory address
# $t3: the virtual memory page number
# $t4: the physical memory page number
# $t5: the valid flag
# $t6: the offset address in the virtual memory page
# $t7: the starting memory address of the target physical memory page
# $t8: the final physical memory address

main:
      # obtain the segment table size ----------------------------------------------
     
      # obtain the VMT table size --------------------------------------------------
     
      # prompt the target segment number -------------------------------------------
          
      # prompt the target segment offset address -----------------------------------
          
      # prompt the virtual memory page size ----------------------------------------

      # calculate the location in the segment table ---------------------------------       

      # check the segmentation fault ------------------------------------------------

      # display the segmentation fault error message and terminate ------------------

      # if no segmentation fault -----------------------------------------------------

      # calulate the virtual memory address ------------------------------------------

      # calculate the virtual page number ---------------------------------------------

      # calculate the location in the VMT --------------------------------------------

      # check the page fault ----------------------------------------------------------

      # display the page fault message ------------------------------------------------

      # if no page fault ---------------------------------------------------------------

      # calculate the offset address in the virtual memory page ------------------------

      # find the starting memory address of the target physical memory page ------------

      # calculate the final physical memory address ------------------------------------

      # display the final result -------------------------------------------------------

      jr $31
##########################################################################################