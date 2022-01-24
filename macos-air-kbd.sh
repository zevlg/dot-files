#!/bin/sh

# MacBook air keyboard rebinds

#      dst  |    src   | src - dst
# ---------------------------------
# rCommand <-> rOption : e7 <-> e6
# lCommand <-> lControl: e3 <-> e0
#   lShift  -> `       : 35  -> e1
#        `  -> ±       : 64  -> 35
#        \  -> Enter   : 31  -> 28
hidutil property --set '{"UserKeyMapping":
    [{"HIDKeyboardModifierMappingSrc":0x7000000e7,
      "HIDKeyboardModifierMappingDst":0x7000000e6},
     {"HIDKeyboardModifierMappingSrc":0x7000000e6,
      "HIDKeyboardModifierMappingDst":0x7000000e7},

     {"HIDKeyboardModifierMappingSrc":0x7000000e0,
      "HIDKeyboardModifierMappingDst":0x7000000e3},
     {"HIDKeyboardModifierMappingSrc":0x7000000e3,
      "HIDKeyboardModifierMappingDst":0x7000000e0},

     {"HIDKeyboardModifierMappingSrc":0x700000035,
      "HIDKeyboardModifierMappingDst":0x7000000e1},

     {"HIDKeyboardModifierMappingSrc":0x700000064,
      "HIDKeyboardModifierMappingDst":0x700000035},

     {"HIDKeyboardModifierMappingSrc":0x700000031,
      "HIDKeyboardModifierMappingDst":0x700000028}
    ]
}'
