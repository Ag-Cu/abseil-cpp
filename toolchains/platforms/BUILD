# File: toolchains/platforms/BUILD
package(default_visibility = ["//visibility:public"])

constraint_setting(name = "cpu")
constraint_value(
    name = "riscv64",
    constraint_setting = ":cpu",
)

constraint_setting(name = "os")
constraint_value(
    name = "linux",
    constraint_setting = ":os",
)

platform(
    name = "riscv64_linux",
    constraint_values = [
        ":riscv64",
        ":linux",
    ],
)