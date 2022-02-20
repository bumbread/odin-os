package stivale2
import "kern:cpu"
import "kern:boot"
import "kern:."

// Note: change this when Odin supports calling startup_runtime directly
//foreign _ {
    //@(link_name="__$startup_runtime")
    //kstartup_runtime :: proc "c" () ---
//}

@(export, link_name="kstartup")
kstartup :: proc "sysv" (params: ^stivale2_struct) {
    // Set up odin environment
    cpu.enable_sse()
    boot.kstartup_runtime()

    context = {
        assertion_failure_proc = kernel.kassert,
    }

    kernel.kmain()
}
