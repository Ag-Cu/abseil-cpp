# File: toolchains/riscv_linux_toolchain/BUILD
package(default_visibility = ["//visibility:public"])

load(":riscv_toolchain_config.bzl", "riscv_toolchain_config")

filegroup(
    name = "all_riscv_toolchain_files",
    # Ideally, populate this with actual toolchain files or ensure
    # the hardcoded paths in your .bzl are correctly handled by Bazel's sandboxing.
    # srcs = glob(["actual_toolchain_files/**"]),
)

# Step 1: cc_toolchain_config rule (defines tool paths, flags, etc.)
riscv_toolchain_config(name = "riscv_linux_config_impl")

# Step 2: cc_toolchain rule (the C++ specific toolchain implementation)
cc_toolchain(
    name = "riscv_linux_cc_toolchain_impl", # Clearer name for the implementation detail
    toolchain_identifier = "riscv-linux-toolchain", # User-defined identifier
    toolchain_config = ":riscv_linux_config_impl",   # Points to the config
    all_files = ":all_riscv_toolchain_files",
    compiler_files = ":all_riscv_toolchain_files",
    dwp_files = ":all_riscv_toolchain_files",
    linker_files = ":all_riscv_toolchain_files",
    objcopy_files = ":all_riscv_toolchain_files",
    strip_files = ":all_riscv_toolchain_files",
    supports_param_files = False,
    target_compatible_with = [ # Constraints for what this toolchain can target
        "//toolchains/platforms:riscv64",
        "//toolchains/platforms:linux",
    ],
)

# Step 3: toolchain rule (the wrapper that provides DeclaredToolchainInfo)
# This is the target that gets registered.
toolchain(
    name = "riscv_linux_toolchain_definition", # Standard name for the definition
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type", # Specifies it's a C++ toolchain
    exec_compatible_with = [ # Constraints for the machine where the compiler RUNS (your host)
        # Adjust these if your build host is not x86_64 Linux
        "@platforms//os:linux",
        "@platforms//cpu:x86_64",
    ],
    target_compatible_with = [ # Constraints for the machine the code is compiled FOR
        "//toolchains/platforms:riscv64",
        "//toolchains/platforms:linux",
    ],
    toolchain = ":riscv_linux_cc_toolchain_impl", # Points to your cc_toolchain implementation
)

# Step 4: cc_toolchain_suite (Likely NOT NEEDED for registration with modern Bazel)
# If you keep this for other organizational purposes or legacy compatibility (--crosstool_top),
# its 'toolchains' attribute should point to ':riscv_linux_toolchain_definition'.
# However, it should NOT be the target passed to register_toolchains() in MODULE.bazel
# for platform-based resolution.
#
# cc_toolchain_suite(
# name = "riscv_suite",
# toolchains = {
# "riscv64|linux": ":riscv_linux_toolchain_definition",
# # You might also need to include a host toolchain definition here if using --crosstool_top
# # "k8": "@local_config_cc//:cc-compiler-k8_toolchain_definition" # (Assuming k8 is your host and has a similar 'toolchain' wrapper)
# },
# )