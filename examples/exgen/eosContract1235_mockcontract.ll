; ModuleID = './eosContract1235_mockcontract.bc'
source_filename = "./eosContract1235_mockcontract.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.wasm_rt_memory_t = type { i8*, i32, i32, i32 }
%struct.wasm_rt_table_t = type { %struct.wasm_rt_elem_t*, i32, i32 }
%struct.wasm_rt_elem_t = type { i32, void ()* }

@Z_memory = common dso_local global %struct.wasm_rt_memory_t* null, align 8
@Z___indirect_function_table = common dso_local global %struct.wasm_rt_table_t* null, align 8
@Z___heap_baseZ_i = common dso_local global i32* null, align 8
@Z___data_endZ_i = common dso_local global i32* null, align 8
@Z_initZ_vv = common dso_local global void ()* null, align 8
@Z_applyZ_vjjj = common dso_local global void (i64, i64, i64)* null, align 8
@func_types = internal global [3 x i32] zeroinitializer, align 4
@g0 = internal global i32 0, align 4
@__heap_base = internal global i32 0, align 4
@__data_end = internal global i32 0, align 4
@memory = internal global %struct.wasm_rt_memory_t zeroinitializer, align 8
@__indirect_function_table = internal global %struct.wasm_rt_table_t zeroinitializer, align 8
@wasm_rt_call_stack_depth = external dso_local global i32, align 4
@Z_envZ_printiZ_vj = external dso_local global void (i64)*, align 8
@Z_envZ_printnZ_vj = external dso_local global void (i64)*, align 8

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @init() #0 {
  call void @init_func_types()
  call void @init_globals()
  call void @init_memory()
  call void @init_table()
  call void @init_exports()
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_func_types() #0 {
  %1 = call i32 (i32, i32, ...) @wasm_rt_register_func_type(i32 1, i32 0, i32 1)
  store i32 %1, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @func_types, i64 0, i64 0), align 4
  %2 = call i32 (i32, i32, ...) @wasm_rt_register_func_type(i32 0, i32 0)
  store i32 %2, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @func_types, i64 0, i64 1), align 4
  %3 = call i32 (i32, i32, ...) @wasm_rt_register_func_type(i32 3, i32 0, i32 1, i32 1, i32 1)
  store i32 %3, i32* getelementptr inbounds ([3 x i32], [3 x i32]* @func_types, i64 0, i64 2), align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_globals() #0 {
  store i32 1048576, i32* @g0, align 4
  store i32 1048576, i32* @__heap_base, align 4
  store i32 1048576, i32* @__data_end, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_memory() #0 {
  call void @wasm_rt_allocate_memory(%struct.wasm_rt_memory_t* @memory, i32 16, i32 65536)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_table() #0 {
  %1 = alloca i32, align 4
  call void @wasm_rt_allocate_table(%struct.wasm_rt_table_t* @__indirect_function_table, i32 1, i32 1)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_exports() #0 {
  store %struct.wasm_rt_memory_t* @memory, %struct.wasm_rt_memory_t** @Z_memory, align 8
  store %struct.wasm_rt_table_t* @__indirect_function_table, %struct.wasm_rt_table_t** @Z___indirect_function_table, align 8
  store i32* @__heap_base, i32** @Z___heap_baseZ_i, align 8
  store i32* @__data_end, i32** @Z___data_endZ_i, align 8
  store void ()* @init_0, void ()** @Z_initZ_vv, align 8
  store void (i64, i64, i64)* @apply, void (i64, i64, i64)** @Z_applyZ_vjjj, align 8
  ret void
}

declare dso_local i32 @wasm_rt_register_func_type(i32, i32, ...) #1

declare dso_local void @wasm_rt_allocate_memory(%struct.wasm_rt_memory_t*, i32, i32) #1

declare dso_local void @wasm_rt_allocate_table(%struct.wasm_rt_table_t*, i32, i32) #1

; Function Attrs: noinline nounwind optnone uwtable
define internal void @init_0() #0 {
  %1 = alloca i64, align 8
  %2 = load i32, i32* @wasm_rt_call_stack_depth, align 4
  %3 = add i32 %2, 1
  store i32 %3, i32* @wasm_rt_call_stack_depth, align 4
  %4 = icmp ugt i32 %3, 500
  br i1 %4, label %5, label %6

; <label>:5:                                      ; preds = %0
  call void @wasm_rt_trap(i32 7) #3
  unreachable

; <label>:6:                                      ; preds = %0
  store i64 5, i64* %1, align 8
  %7 = load void (i64)*, void (i64)** @Z_envZ_printiZ_vj, align 8
  %8 = load i64, i64* %1, align 8
  call void %7(i64 %8)
  %9 = load i32, i32* @wasm_rt_call_stack_depth, align 4
  %10 = add i32 %9, -1
  store i32 %10, i32* @wasm_rt_call_stack_depth, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define internal void @apply(i64, i64, i64) #0 {
  %4 = alloca i64, align 8
  %5 = alloca i64, align 8
  %6 = alloca i64, align 8
  %7 = alloca i64, align 8
  store i64 %0, i64* %4, align 8
  store i64 %1, i64* %5, align 8
  store i64 %2, i64* %6, align 8
  %8 = load i32, i32* @wasm_rt_call_stack_depth, align 4
  %9 = add i32 %8, 1
  store i32 %9, i32* @wasm_rt_call_stack_depth, align 4
  %10 = icmp ugt i32 %9, 500
  br i1 %10, label %11, label %12

; <label>:11:                                     ; preds = %3
  call void @wasm_rt_trap(i32 7) #3
  unreachable

; <label>:12:                                     ; preds = %3
  %13 = load i64, i64* %4, align 8
  store i64 %13, i64* %7, align 8
  %14 = load void (i64)*, void (i64)** @Z_envZ_printnZ_vj, align 8
  %15 = load i64, i64* %7, align 8
  call void %14(i64 %15)
  %16 = load i32, i32* @wasm_rt_call_stack_depth, align 4
  %17 = add i32 %16, -1
  store i32 %17, i32* @wasm_rt_call_stack_depth, align 4
  ret void
}

; Function Attrs: noreturn
declare dso_local void @wasm_rt_trap(i32) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 7.0.0 "}
