/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20200110 (64-bit version)
 * Copyright (c) 2000 - 2020 Intel Corporation
 * 
 * Disassembling to symbolic ASL+ operators
 *
 * Disassembly of iASLf1lJ5p.aml, Wed Apr 15 20:58:50 2020
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000000C4 (196)
 *     Revision         0x02
 *     Checksum         0x1C
 *     OEM ID           "hack"
 *     OEM Table ID     "I2C"
 *     OEM Revision     0x00000000 (0)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20200110 (538968336)
 */
DefinitionBlock ("", "SSDT", 2, "hack", "I2C", 0x00000000)
{
    External (_SB_.PCI0.GPI0, DeviceObj)
    External (_SB_.PCI0.I2C0.TPD0, DeviceObj)
    External (_SB_.PCI0.I2C0.TPD0.SBFB, FieldUnitObj)
    External (_SB_.PCI0.I2C0.TPD0.SBFG, FieldUnitObj)

    Scope (_SB.PCI0.GPI0)
    {
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (0x0F)
        }
    }

    Scope (_SB.PCI0.I2C0.TPD0)
    {
        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            Return (ConcatenateResTemplate (SBFB, SBFG))
        }
    }
}

