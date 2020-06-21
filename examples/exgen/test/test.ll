; ModuleID = '/home/zode/Dataset/Klee/examples/exgen/test/test.bc'
source_filename = "test.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@a = common dso_local global i32 0, align 4, !dbg !0
@b = common dso_local global i32 0, align 4, !dbg !6

; Function Attrs: noinline nounwind sspstrong uwtable
define dso_local i32 @plus() #0 !dbg !15 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %1, metadata !18, metadata !DIExpression()), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %2, metadata !20, metadata !DIExpression()), !dbg !21
  %3 = load i32, i32* @a, align 4, !dbg !22
  %4 = load i32, i32* @b, align 4, !dbg !23
  %5 = add nsw i32 %3, %4, !dbg !24
  store i32 %5, i32* %1, align 4, !dbg !25
  %6 = load i32, i32* @a, align 4, !dbg !26
  %7 = icmp sgt i32 %6, 0, !dbg !28
  br i1 %7, label %8, label %24, !dbg !29

8:                                                ; preds = %0
  %9 = load i32, i32* @b, align 4, !dbg !30
  %10 = icmp sgt i32 %9, 0, !dbg !31
  br i1 %10, label %11, label %24, !dbg !32

11:                                               ; preds = %8
  %12 = load i32, i32* %1, align 4, !dbg !33
  %13 = load i32, i32* @a, align 4, !dbg !36
  %14 = icmp slt i32 %12, %13, !dbg !37
  br i1 %14, label %15, label %16, !dbg !38

15:                                               ; preds = %11
  store i32 1, i32* %2, align 4, !dbg !39
  br label %23, !dbg !40

16:                                               ; preds = %11
  %17 = load i32, i32* %1, align 4, !dbg !41
  %18 = load i32, i32* @a, align 4, !dbg !43
  %19 = icmp eq i32 %17, %18, !dbg !44
  br i1 %19, label %20, label %21, !dbg !45

20:                                               ; preds = %16
  store i32 -1, i32* %2, align 4, !dbg !46
  br label %22, !dbg !47

21:                                               ; preds = %16
  store i32 0, i32* %2, align 4, !dbg !48
  br label %22

22:                                               ; preds = %21, %20
  br label %23

23:                                               ; preds = %22, %15
  br label %24, !dbg !49

24:                                               ; preds = %23, %8, %0
  %25 = load i32, i32* %2, align 4, !dbg !50
  ret i32 %25, !dbg !51
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind sspstrong uwtable
define dso_local i32 @main() #0 !dbg !52 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %2 = call i32 @plus(), !dbg !53
  ret i32 0, !dbg !54
}

attributes #0 = { noinline nounwind sspstrong uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!9, !10, !11, !12, !13}
!llvm.ident = !{!14}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "a", scope: !2, file: !3, line: 3, type: !8, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "test.c", directory: "/home/zode/Dataset/Klee/examples/exgen")
!4 = !{}
!5 = !{!0, !6}
!6 = !DIGlobalVariableExpression(var: !7, expr: !DIExpression())
!7 = distinct !DIGlobalVariable(name: "b", scope: !2, file: !3, line: 3, type: !8, isLocal: false, isDefinition: true)
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !{i32 7, !"Dwarf Version", i32 4}
!10 = !{i32 2, !"Debug Info Version", i32 3}
!11 = !{i32 1, !"wchar_size", i32 4}
!12 = !{i32 7, !"PIC Level", i32 2}
!13 = !{i32 7, !"PIE Level", i32 2}
!14 = !{!"clang version 10.0.0 "}
!15 = distinct !DISubprogram(name: "plus", scope: !3, file: !3, line: 5, type: !16, scopeLine: 5, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!16 = !DISubroutineType(types: !17)
!17 = !{!8}
!18 = !DILocalVariable(name: "c", scope: !15, file: !3, line: 6, type: !8)
!19 = !DILocation(line: 6, column: 7, scope: !15)
!20 = !DILocalVariable(name: "result", scope: !15, file: !3, line: 6, type: !8)
!21 = !DILocation(line: 6, column: 10, scope: !15)
!22 = !DILocation(line: 12, column: 7, scope: !15)
!23 = !DILocation(line: 12, column: 11, scope: !15)
!24 = !DILocation(line: 12, column: 9, scope: !15)
!25 = !DILocation(line: 12, column: 5, scope: !15)
!26 = !DILocation(line: 14, column: 7, scope: !27)
!27 = distinct !DILexicalBlock(scope: !15, file: !3, line: 14, column: 7)
!28 = !DILocation(line: 14, column: 9, scope: !27)
!29 = !DILocation(line: 14, column: 13, scope: !27)
!30 = !DILocation(line: 14, column: 16, scope: !27)
!31 = !DILocation(line: 14, column: 18, scope: !27)
!32 = !DILocation(line: 14, column: 7, scope: !15)
!33 = !DILocation(line: 15, column: 9, scope: !34)
!34 = distinct !DILexicalBlock(scope: !35, file: !3, line: 15, column: 9)
!35 = distinct !DILexicalBlock(scope: !27, file: !3, line: 14, column: 23)
!36 = !DILocation(line: 15, column: 13, scope: !34)
!37 = !DILocation(line: 15, column: 11, scope: !34)
!38 = !DILocation(line: 15, column: 9, scope: !35)
!39 = !DILocation(line: 16, column: 14, scope: !34)
!40 = !DILocation(line: 16, column: 7, scope: !34)
!41 = !DILocation(line: 17, column: 13, scope: !42)
!42 = distinct !DILexicalBlock(scope: !34, file: !3, line: 17, column: 13)
!43 = !DILocation(line: 17, column: 18, scope: !42)
!44 = !DILocation(line: 17, column: 15, scope: !42)
!45 = !DILocation(line: 17, column: 13, scope: !34)
!46 = !DILocation(line: 18, column: 14, scope: !42)
!47 = !DILocation(line: 18, column: 7, scope: !42)
!48 = !DILocation(line: 20, column: 14, scope: !42)
!49 = !DILocation(line: 21, column: 3, scope: !35)
!50 = !DILocation(line: 23, column: 10, scope: !15)
!51 = !DILocation(line: 23, column: 3, scope: !15)
!52 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 26, type: !16, scopeLine: 26, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!53 = !DILocation(line: 27, column: 3, scope: !52)
!54 = !DILocation(line: 29, column: 3, scope: !52)
