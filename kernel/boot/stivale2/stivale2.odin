package stivale2

// Header provided by the kernel in .stivale2hdr section
stivale2_hdr :: struct {
    entry: u64,
    stack: uintptr,
    flags: u64,
    tags: ^stivale2_tag, 
}

// Structure returned by the bootloader
stivale2_struct :: struct {
    bootloader_brand: [64]u8,
    bootloader_version: [64]u8,
    tags: ^stivale2_tag,
}

// All the data that kernel and bootloader exchange
// is to be stored in tags. HEADER tags are the ones
// that the kernel provides to the bootloader and the
// STRUCT tags are the ones that bootloader provides
// to the bootloader. Make sure that you initialize
// HEADER tags at compile-time.
stivale2_tag :: struct{
    id: u64,
    next: ^stivale2_tag,
}

STIVALE2_HEADER_TAG_ANY_VIDEO_ID::           0xc75c9fa92a44c4db
STIVALE2_HEADER_TAG_FRAMEBUFFER_ID::         0x3ecc1bc43d0f7971
STIVALE2_HEADER_TAG_FB_MTRR_ID::             0x4c7bb07731282e00
STIVALE2_HEADER_TAG_SLIDE_HHDM_ID::          0xdc29269c2af53d1d
STIVALE2_HEADER_TAG_TERMINAL_ID::            0xa85d499b1823be72
STIVALE2_HEADER_TAG_SMP_ID::                 0x1ab015085f3273df
STIVALE2_HEADER_TAG_5LV_PAGING_ID::          0x932f477032007e8f
STIVALE2_HEADER_TAG_UNMAP_NULL_ID::          0x92919432b16fe7e7

STIVALE2_STRUCT_TAG_PMRS_ID::                0x5df266a64047b6bd
STIVALE2_STRUCT_TAG_KERNEL_BASE_ADDRESS_ID:: 0x060d78874a2a8af0
STIVALE2_STRUCT_TAG_CMDLINE_ID::             0xe5e76a1b4597a781
STIVALE2_STRUCT_TAG_MEMMAP_ID::              0x2187f79e8612de07
STIVALE2_STRUCT_TAG_FRAMEBUFFER_ID::         0x506461d2950408fa

STIVALE2_STRUCT_TAG_EDID_ID::                0x968609d7af96b845
STIVALE2_STRUCT_TAG_TEXTMODE_ID::            0x38d74c23e0dca893
STIVALE2_STRUCT_TAG_FB_MTRR_ID::             0x6bc1a78ebe871172
STIVALE2_STRUCT_TAG_TERMINAL_ID::            0xc2b3f4c3233b0974
STIVALE2_STRUCT_TAG_MODULES_ID::             0x4b6fe466aade04ce
STIVALE2_STRUCT_TAG_RSDP_ID::                0x9e1786930a375e78
STIVALE2_STRUCT_TAG_EPOCH_ID::               0x566a7bed888e1407
STIVALE2_STRUCT_TAG_FIRMWARE_ID::            0x359d837855e3858c
STIVALE2_STRUCT_TAG_EFI_SYSTEM_TABLE_ID::    0x4bc5ec15845b558e
STIVALE2_STRUCT_TAG_KERNEL_FILE_ID::         0xe599d90c2975584a
STIVALE2_STRUCT_TAG_KERNEL_FILE_V2_ID::      0x37c13018a02c6ea2
STIVALE2_STRUCT_TAG_BOOT_VOLUME_ID::         0x9b4358364c19ee62
STIVALE2_STRUCT_TAG_KERNEL_SLIDE_ID::        0xee80847d01506c57
STIVALE2_STRUCT_TAG_SMBIOS_ID::              0x274bd246c62bf7d1
STIVALE2_STRUCT_TAG_SMP_ID::                 0x34d1d96339647025
STIVALE2_STRUCT_TAG_PXE_SERVER_INFO::        0x29d1e96239247032
STIVALE2_STRUCT_TAG_MMIO32_UART::            0xb813f9b8dbc78797
STIVALE2_STRUCT_TAG_DTB::                    0xabb29bd49a2833fa
STIVALE2_STRUCT_TAG_HHDM_ID::                0xb0ed257db18cb58f

STIVALE2_TERM_CB_DEC::           10
STIVALE2_TERM_CB_BELL::          20
STIVALE2_TERM_CB_PRIVATE_ID::    30
STIVALE2_TERM_CB_STATUS_REPORT:: 40
STIVALE2_TERM_CB_POS_REPORT::    50
STIVALE2_TERM_CB_KBD_LEDS::      60
STIVALE2_TERM_CB_MODE::          70
STIVALE2_TERM_CB_LINUX::         80

STIVALE2_TERM_CTX_SIZE::     -1
STIVALE2_TERM_CTX_SAVE::     -2
STIVALE2_TERM_CTX_RESTORE::  -3
STIVALE2_TERM_FULL_REFRESH:: -4

STIVALE2_FBUF_MMODEL_RGB::    1

STIVALE2_PMR_EXECUTABLE:: 1 << 0
STIVALE2_PMR_WRITABLE::   1 << 1
STIVALE2_PMR_READABLE::   1 << 2

STIVALE2_MMAP_USABLE::                 1
STIVALE2_MMAP_RESERVED::               2
STIVALE2_MMAP_ACPI_RECLAIMABLE::       3
STIVALE2_MMAP_ACPI_NVS::               4
STIVALE2_MMAP_BAD_MEMORY::             5
STIVALE2_MMAP_BOOTLOADER_RECLAIMABLE:: 0x1000
STIVALE2_MMAP_KERNEL_AND_MODULES::     0x1001
STIVALE2_MMAP_FRAMEBUFFER::            0x1002

STIVALE2_FIRMWARE_BIOS:: 1 << 0

stivale2_header_tag_any_video:: struct {
    tag: stivale2_tag,
    preference: u64,
}

stivale2_header_tag_framebuffer:: struct {
    tag: stivale2_tag,
    framebuffer_width: u16,
    framebuffer_height: u16,
    framebuffer_bpp: u16,
    unused: u16,
}

stivale2_header_tag_slide_hhdm:: struct {
    tag: stivale2_tag,
    flags: u64,
    alignment: u64,
}

stivale2_header_tag_terminal:: struct {
    tag: stivale2_tag,
    flags: u64,
    callback: u64,
}

stivale2_header_tag_smp:: struct {
    tag: stivale2_tag,
    flags: u64,
}

stivale2_pmr:: struct {
    base: u64,
    length: u64,
    permissions: u64,
}

stivale2_struct_tag_pmrs:: struct {
    tag: stivale2_tag,
    entries: u64,
    pmrs: [0]stivale2_pmr,
}

stivale2_struct_tag_kernel_base_address:: struct {
    tag: stivale2_tag,
    physical_base_address: u64,
    virtual_base_address: u64,
}

stivale2_struct_tag_cmdline:: struct {
    tag: stivale2_tag,
    cmdline: u64,
}

stivale2_mmap_entry:: struct {
    base: u64,
    length: u64,
    type: u32,
    unused: u32,
}

stivale2_struct_tag_memmap:: struct {
    tag: stivale2_tag,
    entries: u64,
    memmap: [0]stivale2_mmap_entry,
}

stivale2_struct_tag_framebuffer:: struct {
    tag: stivale2_tag,
    framebuffer_addr: u64,
    framebuffer_width: u16,
    framebuffer_height: u16,
    framebuffer_pitch: u16,
    framebuffer_bpp: u16,
    memory_model: u8,
    red_mask_size: u8,
    red_mask_shift: u8,
    green_mask_size: u8,
    green_mask_shift: u8,
    blue_mask_size: u8,
    blue_mask_shift: u8,
    unused: u8,
}

stivale2_struct_tag_edid:: struct {
    tag: stivale2_tag,
    edid_size: u64,
    edid_information: [0]u8,
}

stivale2_struct_tag_textmode:: struct {
    tag: stivale2_tag,
    address: u64,
    unused: u16,
    rows: u16,
    cols: u16,
    bytes_per_char: u16,
}

stivale2_struct_tag_terminal:: struct {
    tag: stivale2_tag,
    flags: u32,
    cols: u16,
    rows: u16,
    term_write: u64,
    max_length: u64,
}

stivale2_module:: struct {
    begin: u64,
    end: u64,
    string: [128]u8,
}

stivale2_struct_tag_modules:: struct {
    tag: stivale2_tag,
    module_count: u64,
    modules: [0]stivale2_module,
}

stivale2_struct_tag_rsdp:: struct {
    tag: stivale2_tag,
    rsdp: u64,
}

stivale2_struct_tag_epoch:: struct {
    tag: stivale2_tag,
    epoch: u64,
}

stivale2_struct_tag_firmware:: struct {
    tag: stivale2_tag,
    flags: u64,
}

stivale2_struct_tag_efi_system_table:: struct {
    tag: stivale2_tag,
    system_table: u64,
}

stivale2_struct_tag_kernel_file:: struct {
    tag: stivale2_tag,
    kernel_file: u64,
}

stivale2_struct_tag_kernel_file_v2:: struct {
    tag: stivale2_tag,
    kernel_file: u64,
    kernel_size: u64,
}

stivale2_guid:: struct {
    a: u32,
    b: u16,
    c: u16,
    d: [8]u8,
}

stivale2_struct_tag_boot_volume:: struct {
    tag: stivale2_tag,
    flags: u64,
    guid: stivale2_guid,
    part_guid: stivale2_guid,
}

stivale2_struct_tag_kernel_slide:: struct {
    tag: stivale2_tag,
    kernel_slide: u64,
}

stivale2_struct_tag_smbios:: struct {
    tag: stivale2_tag,
    flags: u64,
    smbios_entry_32: u64,
    smbios_entry_64: u64,
}

stivale2_smp_info:: struct {
    processor_id: u32,
    lapic_id: u32,
    target_stack: u64,
    goto_address: u64,
    extra_argument: u64,
}

stivale2_struct_tag_smp:: struct {
    tag: stivale2_tag,
    flags: u64,
    bsp_lapic_id: u32,
    unused: u32,
    cpu_count: u64,
    smp_info: [0]stivale2_smp_info,
}

stivale2_struct_tag_pxe_server_info:: struct {
    tag: stivale2_tag,
    server_ip: u32,
}

stivale2_struct_tag_mmio32_uart:: struct {
    tag: stivale2_tag,
    addr: u64,
}

stivale2_struct_tag_dtb:: struct {
    tag: stivale2_tag,
    addr: u64,
    size: u64,
}

stivale2_struct_tag_hhdm:: struct {
    tag: stivale2_tag,
    addr: u64,
}

