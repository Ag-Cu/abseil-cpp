# toolchains/riscv_linux_toolchain/riscv_toolchain_config.bzl
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")
load("@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool_path",
)

def _impl(ctx):
    tool_paths = [
        tool_path(name = "gcc", path = "/workspace/toolchain/bin/riscv64-unknown-linux-gnu-gcc"),
        tool_path(name = "ld", path = "/workspace/toolchain/bin/riscv64-unknown-linux-gnu-ld"),
        tool_path(name = "ar", path = "/workspace/toolchain/bin/riscv64-unknown-linux-gnu-ar"),
        tool_path(name = "cpp", path = "/workspace/toolchain/bin/riscv64-unknown-linux-gnu-cpp"),
        tool_path(name = "gcov", path = "/workspace/toolchain/bin/riscv64-unknown-linux-gnu-gcov"),
        tool_path(name = "nm", path = "/workspace/toolchain/bin/riscv64-unknown-linux-gnu-nm"),
        tool_path(name = "objcopy", path = "/workspace/toolchain/bin/riscv64-unknown-linux-gnu-objcopy"),
        tool_path(name = "objdump", path = "/workspace/toolchain/bin/riscv64-unknown-linux-gnu-objdump"),
        tool_path(name = "strip", path = "/workspace/toolchain/bin/riscv64-unknown-linux-gnu-strip"),
    ]

    # 定义编译器和链接器标志
    cxx_flags = ["-march=rv64gcv", "-mabi=lp64d", "-Wall"]
    linker_flags = ["-march=rv64gcv", "-mabi=lp64d", "-static"]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "riscv-linux-toolchain",
        host_system_name = "local",
        target_system_name = "riscv64-unknown-linux-gnu",
        target_cpu = "riscv64",
        target_libc = "glibc",
        compiler = "gcc",
        abi_version = "lp64d",
        abi_libc_version = "unknown",

        cxx_builtin_include_directories = [
            "/usr/riscv64-linux-gnu/include/",
            "/usr/lib/gcc-cross/riscv64-linux-gnu/10/include/",
        ],

        tool_paths = tool_paths,
    )

riscv_toolchain_config = rule(
    implementation = _impl,
    attrs = {},
    provides = [CcToolchainConfigInfo],
)