	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 15, 0	sdk_version 15, 5
	.globl	__Z1fv                          ; -- Begin function _Z1fv
	.p2align	2
__Z1fv:                                 ; @_Z1fv
Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception0
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp0:
Lloh0:
	adrp	x1, l_.str@PAGE
Lloh1:
	add	x1, x1, l_.str@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp1:
; %bb.1:
Lloh2:
	adrp	x1, __ZTISt13runtime_error@GOTPAGE
Lloh3:
	ldr	x1, [x1, __ZTISt13runtime_error@GOTPAGEOFF]
Lloh4:
	adrp	x2, __ZNSt13runtime_errorD1Ev@GOTPAGE
Lloh5:
	ldr	x2, [x2, __ZNSt13runtime_errorD1Ev@GOTPAGEOFF]
	mov	x0, x19
	bl	___cxa_throw
LBB0_2:
Ltmp2:
	mov	x20, x0
	mov	x0, x19
	bl	___cxa_free_exception
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpAdd	Lloh0, Lloh1
	.loh AdrpLdrGot	Lloh4, Lloh5
	.loh AdrpLdrGot	Lloh2, Lloh3
Lfunc_end0:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table0:
Lexception0:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end0-Lcst_begin0
Lcst_begin0:
	.uleb128 Lfunc_begin0-Lfunc_begin0      ; >> Call Site 1 <<
	.uleb128 Ltmp0-Lfunc_begin0             ;   Call between Lfunc_begin0 and Ltmp0
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp0-Lfunc_begin0             ; >> Call Site 2 <<
	.uleb128 Ltmp1-Ltmp0                    ;   Call between Ltmp0 and Ltmp1
	.uleb128 Ltmp2-Lfunc_begin0             ;     jumps to Ltmp2
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp1-Lfunc_begin0             ; >> Call Site 3 <<
	.uleb128 Lfunc_end0-Ltmp1               ;   Call between Ltmp1 and Lfunc_end0
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end0:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
Lfunc_begin1:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception1
; %bb.0:
	sub	sp, sp, #96
	stp	x24, x23, [sp, #32]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp3:
Lloh6:
	adrp	x1, l_.str.5@PAGE
Lloh7:
	add	x1, x1, l_.str.5@PAGEOFF
	bl	__ZNSt13runtime_errorC1EPKc
Ltmp4:
; %bb.1:
Ltmp6:
Lloh8:
	adrp	x1, __ZTISt13runtime_error@GOTPAGE
Lloh9:
	ldr	x1, [x1, __ZTISt13runtime_error@GOTPAGEOFF]
Lloh10:
	adrp	x2, __ZNSt13runtime_errorD1Ev@GOTPAGE
Lloh11:
	ldr	x2, [x2, __ZNSt13runtime_errorD1Ev@GOTPAGEOFF]
	mov	x0, x19
	bl	___cxa_throw
Ltmp7:
	b	LBB1_50
LBB1_2:
Ltmp8:
	mov	x20, x1
	b	LBB1_4
LBB1_3:
Ltmp5:
	mov	x20, x1
	mov	x21, x0
	mov	x0, x19
	bl	___cxa_free_exception
	mov	x0, x21
LBB1_4:
	cmp	w20, #1
	b.eq	LBB1_47
; %bb.5:
	mov	w8, #1                          ; =0x1
	cmp	w20, w8
	b.ne	LBB1_55
LBB1_6:
	bl	___cxa_begin_catch
Ltmp20:
Lloh12:
	adrp	x0, __ZNSt3__14coutE@GOTPAGE
Lloh13:
	ldr	x0, [x0, __ZNSt3__14coutE@GOTPAGEOFF]
Lloh14:
	adrp	x1, l_.str.6@PAGE
Lloh15:
	add	x1, x1, l_.str.6@PAGEOFF
	mov	w2, #15                         ; =0xf
	bl	__ZNSt3__124__put_character_sequenceB8ne190102IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Ltmp21:
; %bb.7:
	mov	x19, x0
	ldr	x8, [x0]
	ldur	x9, [x8, #-24]
Ltmp22:
	add	x8, sp, #24
	add	x0, x0, x9
	bl	__ZNKSt3__18ios_base6getlocEv
Ltmp23:
; %bb.8:
Ltmp24:
Lloh16:
	adrp	x1, __ZNSt3__15ctypeIcE2idE@GOTPAGE
Lloh17:
	ldr	x1, [x1, __ZNSt3__15ctypeIcE2idE@GOTPAGEOFF]
	add	x0, sp, #24
	bl	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp25:
; %bb.9:
	ldr	x8, [x0]
	ldr	x8, [x8, #56]
Ltmp26:
	mov	w1, #10                         ; =0xa
	blr	x8
Ltmp27:
; %bb.10:
	mov	x20, x0
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
Ltmp29:
	mov	x0, x19
	mov	x1, x20
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
Ltmp30:
; %bb.11:
Ltmp31:
	mov	x0, x19
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
Ltmp32:
; %bb.12:
	add	x8, sp, #24
	bl	__ZSt17current_exceptionv
Lloh18:
	adrp	x0, _tmp2@PAGE
Lloh19:
	add	x0, x0, _tmp2@PAGEOFF
	add	x1, sp, #24
	bl	__ZNSt13exception_ptraSERKS_
	add	x0, sp, #24
	bl	__ZNSt13exception_ptrD1Ev
	bl	___cxa_end_catch
	add	x8, sp, #24
	bl	__ZSt17current_exceptionv
Lloh20:
	adrp	x0, _p3@PAGE
Lloh21:
	add	x0, x0, _p3@PAGEOFF
	add	x1, sp, #24
	bl	__ZNSt13exception_ptraSERKS_
	add	x0, sp, #24
	bl	__ZNSt13exception_ptrD1Ev
Lloh22:
	adrp	x0, __ZNSt3__14coutE@GOTPAGE
Lloh23:
	ldr	x0, [x0, __ZNSt3__14coutE@GOTPAGEOFF]
Lloh24:
	adrp	x1, l_.str.7@PAGE
Lloh25:
	add	x1, x1, l_.str.7@PAGEOFF
	mov	w2, #12                         ; =0xc
	bl	__ZNSt3__124__put_character_sequenceB8ne190102IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	str	xzr, [sp, #8]
	adrp	x21, _p1@PAGE
	ldr	x8, [x21, _p1@PAGEOFF]
	cmp	x8, #0
	cset	w1, eq
Ltmp37:
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEb
Ltmp38:
; %bb.13:
	mov	x19, x0
	ldr	x8, [x0]
	ldur	x9, [x8, #-24]
Ltmp39:
	add	x8, sp, #24
	add	x0, x0, x9
	bl	__ZNKSt3__18ios_base6getlocEv
Ltmp40:
; %bb.14:
Ltmp41:
Lloh26:
	adrp	x1, __ZNSt3__15ctypeIcE2idE@GOTPAGE
Lloh27:
	ldr	x1, [x1, __ZNSt3__15ctypeIcE2idE@GOTPAGEOFF]
	add	x0, sp, #24
	bl	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp42:
; %bb.15:
	ldr	x8, [x0]
	ldr	x8, [x8, #56]
Ltmp43:
	mov	w1, #10                         ; =0xa
	blr	x8
Ltmp44:
; %bb.16:
	mov	x20, x0
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
Ltmp46:
	mov	x0, x19
	mov	x1, x20
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
Ltmp47:
; %bb.17:
Ltmp48:
	mov	x0, x19
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
Ltmp49:
; %bb.18:
	add	x0, sp, #8
	bl	__ZNSt13exception_ptrD1Ev
Lloh28:
	adrp	x0, __ZNSt3__14coutE@GOTPAGE
Lloh29:
	ldr	x0, [x0, __ZNSt3__14coutE@GOTPAGEOFF]
Lloh30:
	adrp	x1, l_.str.8@PAGE
Lloh31:
	add	x1, x1, l_.str.8@PAGEOFF
	mov	w2, #12                         ; =0xc
	bl	__ZNSt3__124__put_character_sequenceB8ne190102IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	str	xzr, [sp, #8]
	adrp	x22, _p2@PAGE
	ldr	x8, [x22, _p2@PAGEOFF]
	cmp	x8, #0
	cset	w1, eq
Ltmp51:
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEb
Ltmp52:
; %bb.19:
	mov	x19, x0
	ldr	x8, [x0]
	ldur	x9, [x8, #-24]
Ltmp53:
	add	x8, sp, #24
	add	x0, x0, x9
	bl	__ZNKSt3__18ios_base6getlocEv
Ltmp54:
; %bb.20:
Ltmp55:
Lloh32:
	adrp	x1, __ZNSt3__15ctypeIcE2idE@GOTPAGE
Lloh33:
	ldr	x1, [x1, __ZNSt3__15ctypeIcE2idE@GOTPAGEOFF]
	add	x0, sp, #24
	bl	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp56:
; %bb.21:
	ldr	x8, [x0]
	ldr	x8, [x8, #56]
Ltmp57:
	mov	w1, #10                         ; =0xa
	blr	x8
Ltmp58:
; %bb.22:
	mov	x20, x0
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
Ltmp60:
	mov	x0, x19
	mov	x1, x20
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
Ltmp61:
; %bb.23:
Ltmp62:
	mov	x0, x19
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
Ltmp63:
; %bb.24:
	add	x0, sp, #8
	bl	__ZNSt13exception_ptrD1Ev
Lloh34:
	adrp	x0, __ZNSt3__14coutE@GOTPAGE
Lloh35:
	ldr	x0, [x0, __ZNSt3__14coutE@GOTPAGEOFF]
Lloh36:
	adrp	x1, l_.str.9@PAGE
Lloh37:
	add	x1, x1, l_.str.9@PAGEOFF
	mov	w2, #12                         ; =0xc
	bl	__ZNSt3__124__put_character_sequenceB8ne190102IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	str	xzr, [sp, #8]
Lloh38:
	adrp	x8, _p3@PAGE
Lloh39:
	ldr	x8, [x8, _p3@PAGEOFF]
	cmp	x8, #0
	cset	w1, eq
Ltmp65:
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEb
Ltmp66:
; %bb.25:
	mov	x19, x0
	ldr	x8, [x0]
	ldur	x9, [x8, #-24]
Ltmp67:
	add	x8, sp, #24
	add	x0, x0, x9
	bl	__ZNKSt3__18ios_base6getlocEv
Ltmp68:
; %bb.26:
Ltmp69:
Lloh40:
	adrp	x1, __ZNSt3__15ctypeIcE2idE@GOTPAGE
Lloh41:
	ldr	x1, [x1, __ZNSt3__15ctypeIcE2idE@GOTPAGEOFF]
	add	x0, sp, #24
	bl	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp70:
; %bb.27:
	ldr	x8, [x0]
	ldr	x8, [x8, #56]
Ltmp71:
	mov	w1, #10                         ; =0xa
	blr	x8
Ltmp72:
; %bb.28:
	mov	x20, x0
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
Ltmp74:
	mov	x0, x19
	mov	x1, x20
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
Ltmp75:
; %bb.29:
Ltmp76:
	mov	x0, x19
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
Ltmp77:
; %bb.30:
	add	x0, sp, #8
	bl	__ZNSt13exception_ptrD1Ev
Lloh42:
	adrp	x0, __ZNSt3__14coutE@GOTPAGE
Lloh43:
	ldr	x0, [x0, __ZNSt3__14coutE@GOTPAGEOFF]
Lloh44:
	adrp	x1, l_.str.10@PAGE
Lloh45:
	add	x1, x1, l_.str.10@PAGEOFF
	mov	w2, #13                         ; =0xd
	bl	__ZNSt3__124__put_character_sequenceB8ne190102IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	str	xzr, [sp, #8]
	adrp	x23, _tmp@PAGE
	ldr	x8, [x23, _tmp@PAGEOFF]
	cmp	x8, #0
	cset	w1, eq
Ltmp79:
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEb
Ltmp80:
; %bb.31:
	mov	x19, x0
	ldr	x8, [x0]
	ldur	x9, [x8, #-24]
Ltmp81:
	add	x8, sp, #24
	add	x0, x0, x9
	bl	__ZNKSt3__18ios_base6getlocEv
Ltmp82:
; %bb.32:
Ltmp83:
Lloh46:
	adrp	x1, __ZNSt3__15ctypeIcE2idE@GOTPAGE
Lloh47:
	ldr	x1, [x1, __ZNSt3__15ctypeIcE2idE@GOTPAGEOFF]
	add	x0, sp, #24
	bl	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp84:
; %bb.33:
	ldr	x8, [x0]
	ldr	x8, [x8, #56]
Ltmp85:
	mov	w1, #10                         ; =0xa
	blr	x8
Ltmp86:
; %bb.34:
	mov	x20, x0
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
Ltmp88:
	mov	x0, x19
	mov	x1, x20
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
Ltmp89:
; %bb.35:
Ltmp90:
	mov	x0, x19
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
Ltmp91:
; %bb.36:
	add	x0, sp, #8
	bl	__ZNSt13exception_ptrD1Ev
Lloh48:
	adrp	x0, __ZNSt3__14coutE@GOTPAGE
Lloh49:
	ldr	x0, [x0, __ZNSt3__14coutE@GOTPAGEOFF]
Lloh50:
	adrp	x1, l_.str.11@PAGE
Lloh51:
	add	x1, x1, l_.str.11@PAGEOFF
	mov	w2, #14                         ; =0xe
	bl	__ZNSt3__124__put_character_sequenceB8ne190102IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	str	xzr, [sp, #8]
	adrp	x24, _tmp2@PAGE
	ldr	x8, [x24, _tmp2@PAGEOFF]
	cmp	x8, #0
	cset	w1, eq
Ltmp93:
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEb
Ltmp94:
; %bb.37:
	mov	x19, x0
	ldr	x8, [x0]
	ldur	x9, [x8, #-24]
Ltmp95:
	add	x8, sp, #24
	add	x0, x0, x9
	bl	__ZNKSt3__18ios_base6getlocEv
Ltmp96:
; %bb.38:
Ltmp97:
Lloh52:
	adrp	x1, __ZNSt3__15ctypeIcE2idE@GOTPAGE
Lloh53:
	ldr	x1, [x1, __ZNSt3__15ctypeIcE2idE@GOTPAGEOFF]
	add	x0, sp, #24
	bl	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp98:
; %bb.39:
	ldr	x8, [x0]
	ldr	x8, [x8, #56]
Ltmp99:
	mov	w1, #10                         ; =0xa
	blr	x8
Ltmp100:
; %bb.40:
	mov	x20, x0
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
Ltmp102:
	mov	x0, x19
	mov	x1, x20
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
Ltmp103:
; %bb.41:
Ltmp104:
	mov	x0, x19
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
Ltmp105:
; %bb.42:
	add	x0, sp, #8
	bl	__ZNSt13exception_ptrD1Ev
Lloh54:
	adrp	x0, __ZNSt3__14coutE@GOTPAGE
Lloh55:
	ldr	x0, [x0, __ZNSt3__14coutE@GOTPAGEOFF]
Lloh56:
	adrp	x1, l_.str.12@PAGE
Lloh57:
	add	x1, x1, l_.str.12@PAGEOFF
	mov	w2, #10                         ; =0xa
	bl	__ZNSt3__124__put_character_sequenceB8ne190102IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	ldr	x8, [x21, _p1@PAGEOFF]
	ldr	x9, [x22, _p2@PAGEOFF]
	cmp	x8, x9
	cset	w1, eq
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEb
	mov	x19, x0
	ldr	x8, [x0]
	ldur	x9, [x8, #-24]
	add	x8, sp, #24
	add	x0, x0, x9
	bl	__ZNKSt3__18ios_base6getlocEv
Ltmp107:
Lloh58:
	adrp	x1, __ZNSt3__15ctypeIcE2idE@GOTPAGE
Lloh59:
	ldr	x1, [x1, __ZNSt3__15ctypeIcE2idE@GOTPAGEOFF]
	add	x0, sp, #24
	bl	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp108:
; %bb.43:
	ldr	x8, [x0]
	ldr	x8, [x8, #56]
Ltmp109:
	mov	w1, #10                         ; =0xa
	blr	x8
Ltmp110:
; %bb.44:
	mov	x20, x0
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
	mov	x0, x19
	mov	x1, x20
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
	mov	x0, x19
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
Lloh60:
	adrp	x0, __ZNSt3__14coutE@GOTPAGE
Lloh61:
	ldr	x0, [x0, __ZNSt3__14coutE@GOTPAGEOFF]
Lloh62:
	adrp	x1, l_.str.13@PAGE
Lloh63:
	add	x1, x1, l_.str.13@PAGEOFF
	mov	w2, #13                         ; =0xd
	bl	__ZNSt3__124__put_character_sequenceB8ne190102IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	ldr	x8, [x23, _tmp@PAGEOFF]
	ldr	x9, [x24, _tmp2@PAGEOFF]
	cmp	x8, x9
	cset	w1, eq
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEb
	mov	x19, x0
	ldr	x8, [x0]
	ldur	x9, [x8, #-24]
	add	x8, sp, #24
	add	x0, x0, x9
	bl	__ZNKSt3__18ios_base6getlocEv
Ltmp112:
Lloh64:
	adrp	x1, __ZNSt3__15ctypeIcE2idE@GOTPAGE
Lloh65:
	ldr	x1, [x1, __ZNSt3__15ctypeIcE2idE@GOTPAGEOFF]
	add	x0, sp, #24
	bl	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp113:
; %bb.45:
	ldr	x8, [x0]
	ldr	x8, [x8, #56]
Ltmp114:
	mov	w1, #10                         ; =0xa
	blr	x8
Ltmp115:
; %bb.46:
	mov	x20, x0
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
	mov	x0, x19
	mov	x1, x20
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE3putEc
	mov	x0, x19
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE5flushEv
	mov	w0, #0                          ; =0x0
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #48]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
LBB1_47:
	bl	___cxa_begin_catch
	add	x8, sp, #24
	bl	__ZSt17current_exceptionv
Lloh66:
	adrp	x0, _p1@PAGE
Lloh67:
	add	x0, x0, _p1@PAGEOFF
	add	x1, sp, #24
	bl	__ZNSt13exception_ptraSERKS_
	add	x0, sp, #24
	bl	__ZNSt13exception_ptrD1Ev
Ltmp9:
	bl	__Z1fv
Ltmp10:
	b	LBB1_50
LBB1_48:
Ltmp11:
	bl	___cxa_begin_catch
	add	x8, sp, #24
	bl	__ZSt17current_exceptionv
Lloh68:
	adrp	x0, _tmp@PAGE
Lloh69:
	add	x0, x0, _tmp@PAGEOFF
	add	x1, sp, #24
	bl	__ZNSt13exception_ptraSERKS_
	add	x0, sp, #24
	bl	__ZNSt13exception_ptrD1Ev
Ltmp12:
	bl	___cxa_end_catch
Ltmp13:
; %bb.49:
	add	x8, sp, #24
	bl	__ZSt17current_exceptionv
Lloh70:
	adrp	x0, _p2@PAGE
Lloh71:
	add	x0, x0, _p2@PAGEOFF
	add	x1, sp, #24
	bl	__ZNSt13exception_ptraSERKS_
	add	x0, sp, #24
	bl	__ZNSt13exception_ptrD1Ev
Lloh72:
	adrp	x1, _tmp@PAGE
Lloh73:
	add	x1, x1, _tmp@PAGEOFF
	add	x0, sp, #16
	bl	__ZNSt13exception_ptrC1ERKS_
Ltmp15:
	add	x0, sp, #16
	bl	__ZSt17rethrow_exceptionSt13exception_ptr
Ltmp16:
LBB1_50:
	brk	#0x1
LBB1_51:
Ltmp17:
	mov	x20, x1
	mov	x19, x0
	add	x0, sp, #16
	bl	__ZNSt13exception_ptrD1Ev
	b	LBB1_53
LBB1_52:
Ltmp14:
	mov	x20, x1
	mov	x19, x0
LBB1_53:
Ltmp18:
	bl	___cxa_end_catch
Ltmp19:
; %bb.54:
                                        ; kill: def $w20 killed $w20 killed $x20 def $x20
	mov	x0, x19
	mov	w8, #1                          ; =0x1
	cmp	w20, w8
	b.eq	LBB1_6
LBB1_55:
	str	x0, [sp]                        ; 8-byte Folded Spill
	bl	__Unwind_Resume
LBB1_56:
Ltmp116:
	str	x0, [sp]                        ; 8-byte Folded Spill
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
	ldr	x0, [sp]                        ; 8-byte Folded Reload
	bl	__Unwind_Resume
LBB1_57:
Ltmp111:
	str	x0, [sp]                        ; 8-byte Folded Spill
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
	ldr	x0, [sp]                        ; 8-byte Folded Reload
	bl	__Unwind_Resume
LBB1_58:
Ltmp101:
	b	LBB1_63
LBB1_59:
Ltmp87:
	b	LBB1_63
LBB1_60:
Ltmp73:
	b	LBB1_63
LBB1_61:
Ltmp59:
	b	LBB1_63
LBB1_62:
Ltmp45:
LBB1_63:
	str	x0, [sp]                        ; 8-byte Folded Spill
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
	b	LBB1_71
LBB1_64:
Ltmp28:
	str	x0, [sp]                        ; 8-byte Folded Spill
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
	b	LBB1_74
LBB1_65:
Ltmp106:
	b	LBB1_70
LBB1_66:
Ltmp92:
	b	LBB1_70
LBB1_67:
Ltmp78:
	b	LBB1_70
LBB1_68:
Ltmp64:
	b	LBB1_70
LBB1_69:
Ltmp50:
LBB1_70:
	str	x0, [sp]                        ; 8-byte Folded Spill
LBB1_71:
	add	x0, sp, #8
	bl	__ZNSt13exception_ptrD1Ev
LBB1_72:
	ldr	x0, [sp]                        ; 8-byte Folded Reload
	bl	__Unwind_Resume
LBB1_73:
Ltmp33:
	str	x0, [sp]                        ; 8-byte Folded Spill
LBB1_74:
Ltmp34:
	bl	___cxa_end_catch
Ltmp35:
	b	LBB1_72
LBB1_75:
Ltmp36:
	bl	___clang_call_terminate
	.loh AdrpAdd	Lloh6, Lloh7
	.loh AdrpLdrGot	Lloh10, Lloh11
	.loh AdrpLdrGot	Lloh8, Lloh9
	.loh AdrpAdd	Lloh14, Lloh15
	.loh AdrpLdrGot	Lloh12, Lloh13
	.loh AdrpLdrGot	Lloh16, Lloh17
	.loh AdrpAdd	Lloh24, Lloh25
	.loh AdrpLdrGot	Lloh22, Lloh23
	.loh AdrpAdd	Lloh20, Lloh21
	.loh AdrpAdd	Lloh18, Lloh19
	.loh AdrpLdrGot	Lloh26, Lloh27
	.loh AdrpAdd	Lloh30, Lloh31
	.loh AdrpLdrGot	Lloh28, Lloh29
	.loh AdrpLdrGot	Lloh32, Lloh33
	.loh AdrpLdr	Lloh38, Lloh39
	.loh AdrpAdd	Lloh36, Lloh37
	.loh AdrpLdrGot	Lloh34, Lloh35
	.loh AdrpLdrGot	Lloh40, Lloh41
	.loh AdrpAdd	Lloh44, Lloh45
	.loh AdrpLdrGot	Lloh42, Lloh43
	.loh AdrpLdrGot	Lloh46, Lloh47
	.loh AdrpAdd	Lloh50, Lloh51
	.loh AdrpLdrGot	Lloh48, Lloh49
	.loh AdrpLdrGot	Lloh52, Lloh53
	.loh AdrpLdrGot	Lloh58, Lloh59
	.loh AdrpAdd	Lloh56, Lloh57
	.loh AdrpLdrGot	Lloh54, Lloh55
	.loh AdrpLdrGot	Lloh64, Lloh65
	.loh AdrpAdd	Lloh62, Lloh63
	.loh AdrpLdrGot	Lloh60, Lloh61
	.loh AdrpAdd	Lloh66, Lloh67
	.loh AdrpAdd	Lloh68, Lloh69
	.loh AdrpAdd	Lloh72, Lloh73
	.loh AdrpAdd	Lloh70, Lloh71
Lfunc_end1:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table1:
Lexception1:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	155                             ; @TType Encoding = indirect pcrel sdata4
	.uleb128 Lttbase0-Lttbaseref0
Lttbaseref0:
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end1-Lcst_begin1
Lcst_begin1:
	.uleb128 Lfunc_begin1-Lfunc_begin1      ; >> Call Site 1 <<
	.uleb128 Ltmp3-Lfunc_begin1             ;   Call between Lfunc_begin1 and Ltmp3
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp3-Lfunc_begin1             ; >> Call Site 2 <<
	.uleb128 Ltmp4-Ltmp3                    ;   Call between Ltmp3 and Ltmp4
	.uleb128 Ltmp5-Lfunc_begin1             ;     jumps to Ltmp5
	.byte	5                               ;   On action: 3
	.uleb128 Ltmp6-Lfunc_begin1             ; >> Call Site 3 <<
	.uleb128 Ltmp7-Ltmp6                    ;   Call between Ltmp6 and Ltmp7
	.uleb128 Ltmp8-Lfunc_begin1             ;     jumps to Ltmp8
	.byte	7                               ;   On action: 4
	.uleb128 Ltmp7-Lfunc_begin1             ; >> Call Site 4 <<
	.uleb128 Ltmp20-Ltmp7                   ;   Call between Ltmp7 and Ltmp20
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp20-Lfunc_begin1            ; >> Call Site 5 <<
	.uleb128 Ltmp23-Ltmp20                  ;   Call between Ltmp20 and Ltmp23
	.uleb128 Ltmp33-Lfunc_begin1            ;     jumps to Ltmp33
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp24-Lfunc_begin1            ; >> Call Site 6 <<
	.uleb128 Ltmp27-Ltmp24                  ;   Call between Ltmp24 and Ltmp27
	.uleb128 Ltmp28-Lfunc_begin1            ;     jumps to Ltmp28
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp29-Lfunc_begin1            ; >> Call Site 7 <<
	.uleb128 Ltmp32-Ltmp29                  ;   Call between Ltmp29 and Ltmp32
	.uleb128 Ltmp33-Lfunc_begin1            ;     jumps to Ltmp33
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp32-Lfunc_begin1            ; >> Call Site 8 <<
	.uleb128 Ltmp37-Ltmp32                  ;   Call between Ltmp32 and Ltmp37
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp37-Lfunc_begin1            ; >> Call Site 9 <<
	.uleb128 Ltmp40-Ltmp37                  ;   Call between Ltmp37 and Ltmp40
	.uleb128 Ltmp50-Lfunc_begin1            ;     jumps to Ltmp50
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp41-Lfunc_begin1            ; >> Call Site 10 <<
	.uleb128 Ltmp44-Ltmp41                  ;   Call between Ltmp41 and Ltmp44
	.uleb128 Ltmp45-Lfunc_begin1            ;     jumps to Ltmp45
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp46-Lfunc_begin1            ; >> Call Site 11 <<
	.uleb128 Ltmp49-Ltmp46                  ;   Call between Ltmp46 and Ltmp49
	.uleb128 Ltmp50-Lfunc_begin1            ;     jumps to Ltmp50
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp49-Lfunc_begin1            ; >> Call Site 12 <<
	.uleb128 Ltmp51-Ltmp49                  ;   Call between Ltmp49 and Ltmp51
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp51-Lfunc_begin1            ; >> Call Site 13 <<
	.uleb128 Ltmp54-Ltmp51                  ;   Call between Ltmp51 and Ltmp54
	.uleb128 Ltmp64-Lfunc_begin1            ;     jumps to Ltmp64
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp55-Lfunc_begin1            ; >> Call Site 14 <<
	.uleb128 Ltmp58-Ltmp55                  ;   Call between Ltmp55 and Ltmp58
	.uleb128 Ltmp59-Lfunc_begin1            ;     jumps to Ltmp59
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp60-Lfunc_begin1            ; >> Call Site 15 <<
	.uleb128 Ltmp63-Ltmp60                  ;   Call between Ltmp60 and Ltmp63
	.uleb128 Ltmp64-Lfunc_begin1            ;     jumps to Ltmp64
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp63-Lfunc_begin1            ; >> Call Site 16 <<
	.uleb128 Ltmp65-Ltmp63                  ;   Call between Ltmp63 and Ltmp65
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp65-Lfunc_begin1            ; >> Call Site 17 <<
	.uleb128 Ltmp68-Ltmp65                  ;   Call between Ltmp65 and Ltmp68
	.uleb128 Ltmp78-Lfunc_begin1            ;     jumps to Ltmp78
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp69-Lfunc_begin1            ; >> Call Site 18 <<
	.uleb128 Ltmp72-Ltmp69                  ;   Call between Ltmp69 and Ltmp72
	.uleb128 Ltmp73-Lfunc_begin1            ;     jumps to Ltmp73
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp74-Lfunc_begin1            ; >> Call Site 19 <<
	.uleb128 Ltmp77-Ltmp74                  ;   Call between Ltmp74 and Ltmp77
	.uleb128 Ltmp78-Lfunc_begin1            ;     jumps to Ltmp78
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp77-Lfunc_begin1            ; >> Call Site 20 <<
	.uleb128 Ltmp79-Ltmp77                  ;   Call between Ltmp77 and Ltmp79
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp79-Lfunc_begin1            ; >> Call Site 21 <<
	.uleb128 Ltmp82-Ltmp79                  ;   Call between Ltmp79 and Ltmp82
	.uleb128 Ltmp92-Lfunc_begin1            ;     jumps to Ltmp92
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp83-Lfunc_begin1            ; >> Call Site 22 <<
	.uleb128 Ltmp86-Ltmp83                  ;   Call between Ltmp83 and Ltmp86
	.uleb128 Ltmp87-Lfunc_begin1            ;     jumps to Ltmp87
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp88-Lfunc_begin1            ; >> Call Site 23 <<
	.uleb128 Ltmp91-Ltmp88                  ;   Call between Ltmp88 and Ltmp91
	.uleb128 Ltmp92-Lfunc_begin1            ;     jumps to Ltmp92
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp91-Lfunc_begin1            ; >> Call Site 24 <<
	.uleb128 Ltmp93-Ltmp91                  ;   Call between Ltmp91 and Ltmp93
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp93-Lfunc_begin1            ; >> Call Site 25 <<
	.uleb128 Ltmp96-Ltmp93                  ;   Call between Ltmp93 and Ltmp96
	.uleb128 Ltmp106-Lfunc_begin1           ;     jumps to Ltmp106
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp97-Lfunc_begin1            ; >> Call Site 26 <<
	.uleb128 Ltmp100-Ltmp97                 ;   Call between Ltmp97 and Ltmp100
	.uleb128 Ltmp101-Lfunc_begin1           ;     jumps to Ltmp101
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp102-Lfunc_begin1           ; >> Call Site 27 <<
	.uleb128 Ltmp105-Ltmp102                ;   Call between Ltmp102 and Ltmp105
	.uleb128 Ltmp106-Lfunc_begin1           ;     jumps to Ltmp106
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp105-Lfunc_begin1           ; >> Call Site 28 <<
	.uleb128 Ltmp107-Ltmp105                ;   Call between Ltmp105 and Ltmp107
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp107-Lfunc_begin1           ; >> Call Site 29 <<
	.uleb128 Ltmp110-Ltmp107                ;   Call between Ltmp107 and Ltmp110
	.uleb128 Ltmp111-Lfunc_begin1           ;     jumps to Ltmp111
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp110-Lfunc_begin1           ; >> Call Site 30 <<
	.uleb128 Ltmp112-Ltmp110                ;   Call between Ltmp110 and Ltmp112
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp112-Lfunc_begin1           ; >> Call Site 31 <<
	.uleb128 Ltmp115-Ltmp112                ;   Call between Ltmp112 and Ltmp115
	.uleb128 Ltmp116-Lfunc_begin1           ;     jumps to Ltmp116
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp115-Lfunc_begin1           ; >> Call Site 32 <<
	.uleb128 Ltmp9-Ltmp115                  ;   Call between Ltmp115 and Ltmp9
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp9-Lfunc_begin1             ; >> Call Site 33 <<
	.uleb128 Ltmp10-Ltmp9                   ;   Call between Ltmp9 and Ltmp10
	.uleb128 Ltmp11-Lfunc_begin1            ;     jumps to Ltmp11
	.byte	9                               ;   On action: 5
	.uleb128 Ltmp10-Lfunc_begin1            ; >> Call Site 34 <<
	.uleb128 Ltmp12-Ltmp10                  ;   Call between Ltmp10 and Ltmp12
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp12-Lfunc_begin1            ; >> Call Site 35 <<
	.uleb128 Ltmp13-Ltmp12                  ;   Call between Ltmp12 and Ltmp13
	.uleb128 Ltmp14-Lfunc_begin1            ;     jumps to Ltmp14
	.byte	5                               ;   On action: 3
	.uleb128 Ltmp15-Lfunc_begin1            ; >> Call Site 36 <<
	.uleb128 Ltmp16-Ltmp15                  ;   Call between Ltmp15 and Ltmp16
	.uleb128 Ltmp17-Lfunc_begin1            ;     jumps to Ltmp17
	.byte	5                               ;   On action: 3
	.uleb128 Ltmp18-Lfunc_begin1            ; >> Call Site 37 <<
	.uleb128 Ltmp19-Ltmp18                  ;   Call between Ltmp18 and Ltmp19
	.uleb128 Ltmp36-Lfunc_begin1            ;     jumps to Ltmp36
	.byte	9                               ;   On action: 5
	.uleb128 Ltmp19-Lfunc_begin1            ; >> Call Site 38 <<
	.uleb128 Ltmp34-Ltmp19                  ;   Call between Ltmp19 and Ltmp34
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp34-Lfunc_begin1            ; >> Call Site 39 <<
	.uleb128 Ltmp35-Ltmp34                  ;   Call between Ltmp34 and Ltmp35
	.uleb128 Ltmp36-Lfunc_begin1            ;     jumps to Ltmp36
	.byte	9                               ;   On action: 5
Lcst_end1:
	.byte	0                               ; >> Action Record 1 <<
                                        ;   Cleanup
	.byte	0                               ;   No further actions
	.byte	0                               ; >> Action Record 2 <<
                                        ;   Cleanup
	.byte	125                             ;   Continue to action 1
	.byte	1                               ; >> Action Record 3 <<
                                        ;   Catch TypeInfo 1
	.byte	125                             ;   Continue to action 2
	.byte	1                               ; >> Action Record 4 <<
                                        ;   Catch TypeInfo 1
	.byte	0                               ;   No further actions
	.byte	2                               ; >> Action Record 5 <<
                                        ;   Catch TypeInfo 2
	.byte	0                               ;   No further actions
	.p2align	2, 0x0
                                        ; >> Catch TypeInfos <<
	.long	0                               ; TypeInfo 2
Ltmp145:                                ; TypeInfo 1
	.long	__ZTISt13runtime_error@GOT-Ltmp145
Lttbase0:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	___clang_call_terminate ; -- Begin function __clang_call_terminate
	.globl	___clang_call_terminate
	.weak_def_can_be_hidden	___clang_call_terminate
	.p2align	2
___clang_call_terminate:                ; @__clang_call_terminate
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	___cxa_begin_catch
	bl	__ZSt9terminatev
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__124__put_character_sequenceB8ne190102IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m ; -- Begin function _ZNSt3__124__put_character_sequenceB8ne190102IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.globl	__ZNSt3__124__put_character_sequenceB8ne190102IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.weak_def_can_be_hidden	__ZNSt3__124__put_character_sequenceB8ne190102IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.p2align	2
__ZNSt3__124__put_character_sequenceB8ne190102IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m: ; @_ZNSt3__124__put_character_sequenceB8ne190102IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Lfunc_begin2:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception2
; %bb.0:
	sub	sp, sp, #112
	stp	x26, x25, [sp, #32]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	mov	x21, x2
	mov	x20, x1
	mov	x19, x0
Ltmp117:
	add	x0, sp, #8
	mov	x1, x19
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryC1ERS3_
Ltmp118:
; %bb.1:
	ldrb	w8, [sp, #8]
	cmp	w8, #1
	b.ne	LBB3_10
; %bb.2:
	ldr	x8, [x19]
	ldur	x8, [x8, #-24]
	add	x4, x19, x8
	ldr	x22, [x4, #40]
	ldr	w24, [x4, #8]
	ldr	w23, [x4, #144]
	cmn	w23, #1
	b.ne	LBB3_7
; %bb.3:
Ltmp120:
	add	x8, sp, #24
	mov	x25, x4
	mov	x0, x4
	bl	__ZNKSt3__18ios_base6getlocEv
Ltmp121:
; %bb.4:
Ltmp122:
Lloh74:
	adrp	x1, __ZNSt3__15ctypeIcE2idE@GOTPAGE
Lloh75:
	ldr	x1, [x1, __ZNSt3__15ctypeIcE2idE@GOTPAGEOFF]
	add	x0, sp, #24
	bl	__ZNKSt3__16locale9use_facetERNS0_2idE
Ltmp123:
; %bb.5:
	ldr	x8, [x0]
	ldr	x8, [x8, #56]
Ltmp124:
	mov	w1, #32                         ; =0x20
	blr	x8
Ltmp125:
; %bb.6:
	mov	x23, x0
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
	mov	x4, x25
	str	w23, [x25, #144]
LBB3_7:
	mov	w8, #176                        ; =0xb0
	and	w8, w24, w8
	add	x3, x20, x21
	cmp	w8, #32
	csel	x2, x3, x20, eq
Ltmp127:
	sxtb	w5, w23
	mov	x0, x22
	mov	x1, x20
	bl	__ZNSt3__116__pad_and_outputB8ne190102IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
Ltmp128:
; %bb.8:
	cbnz	x0, LBB3_10
; %bb.9:
	ldr	x8, [x19]
	ldur	x8, [x8, #-24]
	add	x0, x19, x8
	ldr	w8, [x0, #32]
	mov	w9, #5                          ; =0x5
Ltmp130:
	orr	w1, w8, w9
	bl	__ZNSt3__18ios_base5clearEj
Ltmp131:
LBB3_10:
	add	x0, sp, #8
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev
LBB3_11:
	mov	x0, x19
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
LBB3_12:
Ltmp132:
	b	LBB3_15
LBB3_13:
Ltmp126:
	mov	x20, x0
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
	b	LBB3_16
LBB3_14:
Ltmp129:
LBB3_15:
	mov	x20, x0
LBB3_16:
	add	x0, sp, #8
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev
	b	LBB3_18
LBB3_17:
Ltmp119:
	mov	x20, x0
LBB3_18:
	mov	x0, x20
	bl	___cxa_begin_catch
	ldr	x8, [x19]
	ldur	x8, [x8, #-24]
Ltmp133:
	add	x0, x19, x8
	bl	__ZNSt3__18ios_base33__set_badbit_and_consider_rethrowEv
Ltmp134:
; %bb.19:
	bl	___cxa_end_catch
	b	LBB3_11
LBB3_20:
Ltmp135:
	mov	x19, x0
Ltmp136:
	bl	___cxa_end_catch
Ltmp137:
; %bb.21:
	mov	x0, x19
	bl	__Unwind_Resume
LBB3_22:
Ltmp138:
	bl	___clang_call_terminate
	.loh AdrpLdrGot	Lloh74, Lloh75
Lfunc_end2:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table3:
Lexception2:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	155                             ; @TType Encoding = indirect pcrel sdata4
	.uleb128 Lttbase1-Lttbaseref1
Lttbaseref1:
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end2-Lcst_begin2
Lcst_begin2:
	.uleb128 Ltmp117-Lfunc_begin2           ; >> Call Site 1 <<
	.uleb128 Ltmp118-Ltmp117                ;   Call between Ltmp117 and Ltmp118
	.uleb128 Ltmp119-Lfunc_begin2           ;     jumps to Ltmp119
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp120-Lfunc_begin2           ; >> Call Site 2 <<
	.uleb128 Ltmp121-Ltmp120                ;   Call between Ltmp120 and Ltmp121
	.uleb128 Ltmp129-Lfunc_begin2           ;     jumps to Ltmp129
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp122-Lfunc_begin2           ; >> Call Site 3 <<
	.uleb128 Ltmp125-Ltmp122                ;   Call between Ltmp122 and Ltmp125
	.uleb128 Ltmp126-Lfunc_begin2           ;     jumps to Ltmp126
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp127-Lfunc_begin2           ; >> Call Site 4 <<
	.uleb128 Ltmp128-Ltmp127                ;   Call between Ltmp127 and Ltmp128
	.uleb128 Ltmp129-Lfunc_begin2           ;     jumps to Ltmp129
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp130-Lfunc_begin2           ; >> Call Site 5 <<
	.uleb128 Ltmp131-Ltmp130                ;   Call between Ltmp130 and Ltmp131
	.uleb128 Ltmp132-Lfunc_begin2           ;     jumps to Ltmp132
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp131-Lfunc_begin2           ; >> Call Site 6 <<
	.uleb128 Ltmp133-Ltmp131                ;   Call between Ltmp131 and Ltmp133
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp133-Lfunc_begin2           ; >> Call Site 7 <<
	.uleb128 Ltmp134-Ltmp133                ;   Call between Ltmp133 and Ltmp134
	.uleb128 Ltmp135-Lfunc_begin2           ;     jumps to Ltmp135
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp134-Lfunc_begin2           ; >> Call Site 8 <<
	.uleb128 Ltmp136-Ltmp134                ;   Call between Ltmp134 and Ltmp136
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp136-Lfunc_begin2           ; >> Call Site 9 <<
	.uleb128 Ltmp137-Ltmp136                ;   Call between Ltmp136 and Ltmp137
	.uleb128 Ltmp138-Lfunc_begin2           ;     jumps to Ltmp138
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp137-Lfunc_begin2           ; >> Call Site 10 <<
	.uleb128 Lfunc_end2-Ltmp137             ;   Call between Ltmp137 and Lfunc_end2
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end2:
	.byte	1                               ; >> Action Record 1 <<
                                        ;   Catch TypeInfo 1
	.byte	0                               ;   No further actions
	.p2align	2, 0x0
                                        ; >> Catch TypeInfos <<
	.long	0                               ; TypeInfo 1
Lttbase1:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNSt3__116__pad_and_outputB8ne190102IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_ ; -- Begin function _ZNSt3__116__pad_and_outputB8ne190102IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.globl	__ZNSt3__116__pad_and_outputB8ne190102IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.weak_def_can_be_hidden	__ZNSt3__116__pad_and_outputB8ne190102IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.p2align	2
__ZNSt3__116__pad_and_outputB8ne190102IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_: ; @_ZNSt3__116__pad_and_outputB8ne190102IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
Lfunc_begin3:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception3
; %bb.0:
	sub	sp, sp, #112
	stp	x26, x25, [sp, #32]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #48]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #64]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #80]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w25, -72
	.cfi_offset w26, -80
	mov	x19, x0
	cbz	x0, LBB4_16
; %bb.1:
	mov	x24, x5
	mov	x20, x4
	mov	x22, x3
	mov	x21, x2
	ldr	x8, [x4, #24]
	sub	x9, x3, x1
	subs	x8, x8, x9
	csel	x23, x8, xzr, gt
	sub	x25, x2, x1
	cmp	x25, #1
	b.lt	LBB4_3
; %bb.2:
	ldr	x8, [x19]
	ldr	x8, [x8, #96]
	mov	x0, x19
	mov	x2, x25
	blr	x8
	cmp	x0, x25
	b.ne	LBB4_15
LBB4_3:
	cmp	x23, #1
	b.lt	LBB4_12
; %bb.4:
	mov	x8, #9223372036854775800        ; =0x7ffffffffffffff8
	cmp	x23, x8
	b.hs	LBB4_17
; %bb.5:
	cmp	x23, #23
	b.hs	LBB4_7
; %bb.6:
	strb	w23, [sp, #31]
	add	x25, sp, #8
	b	LBB4_8
LBB4_7:
	orr	x8, x23, #0x7
	cmp	x8, #23
	mov	w9, #25                         ; =0x19
	csinc	x26, x9, x8, eq
	mov	x0, x26
	bl	__Znwm
	mov	x25, x0
	orr	x8, x26, #0x8000000000000000
	stp	x23, x8, [sp, #16]
	str	x0, [sp, #8]
LBB4_8:
	mov	x0, x25
	mov	x1, x24
	mov	x2, x23
	bl	_memset
	strb	wzr, [x25, x23]
	ldrsb	w8, [sp, #31]
	ldr	x9, [sp, #8]
	cmp	w8, #0
	add	x8, sp, #8
	csel	x1, x9, x8, lt
	ldr	x8, [x19]
	ldr	x8, [x8, #96]
Ltmp139:
	mov	x0, x19
	mov	x2, x23
	blr	x8
Ltmp140:
; %bb.9:
	ldrsb	w8, [sp, #31]
	tbnz	w8, #31, LBB4_11
; %bb.10:
	cmp	x0, x23
	b.ne	LBB4_15
	b	LBB4_12
LBB4_11:
	ldr	x8, [sp, #8]
	mov	x24, x0
	mov	x0, x8
	bl	__ZdlPv
	cmp	x24, x23
	b.ne	LBB4_15
LBB4_12:
	sub	x22, x22, x21
	cmp	x22, #1
	b.lt	LBB4_14
; %bb.13:
	ldr	x8, [x19]
	ldr	x8, [x8, #96]
	mov	x0, x19
	mov	x1, x21
	mov	x2, x22
	blr	x8
	cmp	x0, x22
	b.ne	LBB4_15
LBB4_14:
	str	xzr, [x20, #24]
	b	LBB4_16
LBB4_15:
	mov	x19, #0                         ; =0x0
LBB4_16:
	mov	x0, x19
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #80]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
LBB4_17:
	add	x0, sp, #8
	bl	__ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne190102Ev
LBB4_18:
Ltmp141:
	mov	x19, x0
	ldrsb	w8, [sp, #31]
	tbz	w8, #31, LBB4_20
; %bb.19:
	ldr	x0, [sp, #8]
	bl	__ZdlPv
LBB4_20:
	mov	x0, x19
	bl	__Unwind_Resume
Lfunc_end3:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table4:
Lexception3:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end3-Lcst_begin3
Lcst_begin3:
	.uleb128 Lfunc_begin3-Lfunc_begin3      ; >> Call Site 1 <<
	.uleb128 Ltmp139-Lfunc_begin3           ;   Call between Lfunc_begin3 and Ltmp139
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp139-Lfunc_begin3           ; >> Call Site 2 <<
	.uleb128 Ltmp140-Ltmp139                ;   Call between Ltmp139 and Ltmp140
	.uleb128 Ltmp141-Lfunc_begin3           ;     jumps to Ltmp141
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp140-Lfunc_begin3           ; >> Call Site 3 <<
	.uleb128 Lfunc_end3-Ltmp140             ;   Call between Ltmp140 and Lfunc_end3
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end3:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne190102Ev ; -- Begin function _ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne190102Ev
	.globl	__ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne190102Ev
	.weak_def_can_be_hidden	__ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne190102Ev
	.p2align	2
__ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne190102Ev: ; @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE20__throw_length_errorB8ne190102Ev
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
Lloh76:
	adrp	x0, l_.str.14@PAGE
Lloh77:
	add	x0, x0, l_.str.14@PAGEOFF
	bl	__ZNSt3__120__throw_length_errorB8ne190102EPKc
	.loh AdrpAdd	Lloh76, Lloh77
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__120__throw_length_errorB8ne190102EPKc ; -- Begin function _ZNSt3__120__throw_length_errorB8ne190102EPKc
	.globl	__ZNSt3__120__throw_length_errorB8ne190102EPKc
	.weak_def_can_be_hidden	__ZNSt3__120__throw_length_errorB8ne190102EPKc
	.p2align	2
__ZNSt3__120__throw_length_errorB8ne190102EPKc: ; @_ZNSt3__120__throw_length_errorB8ne190102EPKc
Lfunc_begin4:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception4
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x20, x0
	mov	w0, #16                         ; =0x10
	bl	___cxa_allocate_exception
	mov	x19, x0
Ltmp142:
	mov	x1, x20
	bl	__ZNSt12length_errorC1B8ne190102EPKc
Ltmp143:
; %bb.1:
Lloh78:
	adrp	x1, __ZTISt12length_error@GOTPAGE
Lloh79:
	ldr	x1, [x1, __ZTISt12length_error@GOTPAGEOFF]
Lloh80:
	adrp	x2, __ZNSt12length_errorD1Ev@GOTPAGE
Lloh81:
	ldr	x2, [x2, __ZNSt12length_errorD1Ev@GOTPAGEOFF]
	mov	x0, x19
	bl	___cxa_throw
LBB6_2:
Ltmp144:
	mov	x20, x0
	mov	x0, x19
	bl	___cxa_free_exception
	mov	x0, x20
	bl	__Unwind_Resume
	.loh AdrpLdrGot	Lloh80, Lloh81
	.loh AdrpLdrGot	Lloh78, Lloh79
Lfunc_end4:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table6:
Lexception4:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end4-Lcst_begin4
Lcst_begin4:
	.uleb128 Lfunc_begin4-Lfunc_begin4      ; >> Call Site 1 <<
	.uleb128 Ltmp142-Lfunc_begin4           ;   Call between Lfunc_begin4 and Ltmp142
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp142-Lfunc_begin4           ; >> Call Site 2 <<
	.uleb128 Ltmp143-Ltmp142                ;   Call between Ltmp142 and Ltmp143
	.uleb128 Ltmp144-Lfunc_begin4           ;     jumps to Ltmp144
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp143-Lfunc_begin4           ; >> Call Site 3 <<
	.uleb128 Lfunc_end4-Ltmp143             ;   Call between Ltmp143 and Lfunc_end4
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end4:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNSt12length_errorC1B8ne190102EPKc ; -- Begin function _ZNSt12length_errorC1B8ne190102EPKc
	.globl	__ZNSt12length_errorC1B8ne190102EPKc
	.weak_def_can_be_hidden	__ZNSt12length_errorC1B8ne190102EPKc
	.p2align	2
__ZNSt12length_errorC1B8ne190102EPKc:   ; @_ZNSt12length_errorC1B8ne190102EPKc
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	__ZNSt11logic_errorC2EPKc
Lloh82:
	adrp	x8, __ZTVSt12length_error@GOTPAGE
Lloh83:
	ldr	x8, [x8, __ZTVSt12length_error@GOTPAGEOFF]
	add	x8, x8, #16
	str	x8, [x0]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.loh AdrpLdrGot	Lloh82, Lloh83
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__StaticInit,regular,pure_instructions
	.p2align	2                               ; -- Begin function _GLOBAL__sub_I_wl.cpp
__GLOBAL__sub_I_wl.cpp:                 ; @_GLOBAL__sub_I_wl.cpp
	.cfi_startproc
; %bb.0:
	stp	x20, x19, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
Lloh84:
	adrp	x1, _p1@PAGE
Lloh85:
	add	x1, x1, _p1@PAGEOFF
	str	xzr, [x1]
Lloh86:
	adrp	x19, __ZNSt13exception_ptrD1Ev@GOTPAGE
Lloh87:
	ldr	x19, [x19, __ZNSt13exception_ptrD1Ev@GOTPAGEOFF]
Lloh88:
	adrp	x20, ___dso_handle@PAGE
Lloh89:
	add	x20, x20, ___dso_handle@PAGEOFF
	mov	x0, x19
	mov	x2, x20
	bl	___cxa_atexit
Lloh90:
	adrp	x1, _p2@PAGE
Lloh91:
	add	x1, x1, _p2@PAGEOFF
	str	xzr, [x1]
	mov	x0, x19
	mov	x2, x20
	bl	___cxa_atexit
Lloh92:
	adrp	x1, _p3@PAGE
Lloh93:
	add	x1, x1, _p3@PAGEOFF
	str	xzr, [x1]
	mov	x0, x19
	mov	x2, x20
	bl	___cxa_atexit
Lloh94:
	adrp	x1, _tmp@PAGE
Lloh95:
	add	x1, x1, _tmp@PAGEOFF
	str	xzr, [x1]
	mov	x0, x19
	mov	x2, x20
	bl	___cxa_atexit
Lloh96:
	adrp	x1, _tmp2@PAGE
Lloh97:
	add	x1, x1, _tmp2@PAGEOFF
	str	xzr, [x1]
	mov	x0, x19
	mov	x2, x20
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp], #32             ; 16-byte Folded Reload
	b	___cxa_atexit
	.loh AdrpAdd	Lloh96, Lloh97
	.loh AdrpAdd	Lloh94, Lloh95
	.loh AdrpAdd	Lloh92, Lloh93
	.loh AdrpAdd	Lloh90, Lloh91
	.loh AdrpAdd	Lloh88, Lloh89
	.loh AdrpLdrGot	Lloh86, Lloh87
	.loh AdrpAdd	Lloh84, Lloh85
	.cfi_endproc
                                        ; -- End function
	.globl	_p1                             ; @p1
.zerofill __DATA,__common,_p1,8,3
	.globl	_p2                             ; @p2
.zerofill __DATA,__common,_p2,8,3
	.globl	_p3                             ; @p3
.zerofill __DATA,__common,_p3,8,3
	.globl	_tmp                            ; @tmp
.zerofill __DATA,__common,_tmp,8,3
	.globl	_tmp2                           ; @tmp2
.zerofill __DATA,__common,_tmp2,8,3
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.space	1

l_.str.5:                               ; @.str.5
	.asciz	"hello"

l_.str.6:                               ; @.str.6
	.asciz	"f exc processed"

l_.str.7:                               ; @.str.7
	.asciz	"p1 is null: "

l_.str.8:                               ; @.str.8
	.asciz	"p2 is null: "

l_.str.9:                               ; @.str.9
	.asciz	"p3 is null: "

l_.str.10:                              ; @.str.10
	.asciz	"tmp is null: "

l_.str.11:                              ; @.str.11
	.asciz	"tmp2 is null: "

l_.str.12:                              ; @.str.12
	.asciz	"p1 == p2: "

l_.str.13:                              ; @.str.13
	.asciz	"tmp == tmp2: "

l_.str.14:                              ; @.str.14
	.asciz	"basic_string"

	.section	__DATA,__mod_init_func,mod_init_funcs
	.p2align	3, 0x0
	.quad	__GLOBAL__sub_I_wl.cpp
.subsections_via_symbols
