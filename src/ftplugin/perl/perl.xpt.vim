XPTemplate priority=lang

let s:f = g:XPTfuncs() 
 
XPTvar $TRUE          1
XPTvar $FALSE         0
XPTvar $NULL          
XPTvar $UNDEFINED     

XPTvar $VOID_LINE     # void;
XPTvar $CURSOR_PH     # cursor

XPTvar $BRif     \ 
XPTvar $BRel   \n
XPTvar $BRfor    \ 
XPTvar $BRwhl  \ 
XPTvar $BRstc \ 
XPTvar $BRfun   \ 

XPTinclude 
      \ _common/common

XPTvar $CS #
XPTinclude 
      \ _comment/singleSign

XPTvar $VAR_PRE    $
XPTvar $FOR_SCOPE  my\ 
XPTinclude 
      \ _loops/for

XPTinclude 
      \ _loops/c.while.like


" ========================= Function and Variables =============================


" ================================= Snippets ===================================
XPTemplateDef


" perl has no NULL value
XPT fornn hidden=1

XPT whilenn hidden=1


XPT perl hint=#!/usr/bin/env\ perl
#!/usr/bin/env perl

..XPT


XPT xif hint=..\ if\ ..;
`expr^ if `cond^;


XPT xwhile hint=..\ while\ ..;
`expr^ while `cond^;


XPT xunless hint=..\ unless\ ..;
`expr^ unless `cond^;


XPT xforeach hint=..\ foreach\ ..;
`expr^ foreach @`array^;


XPT sub hint=sub\ ..\ {\ ..\ }
sub `fun_name^`$BRfun^{
    `cursor^
}


XPT unless hint=unless\ (\ ..\ )\ {\ ..\ }
unless`$SPif^(`$SPcnd^`cond^`$SPcnd^)`$BRif^{
    `cursor^
}


XPT eval hint=eval\ {\ ..\ };if...
eval`$BRif^{
    `risky^
};
if`$SPif^(`$SPcnd^$@`$SPcnd^)`$BRif^{
    `handle^
}

XPT try alias=eval hint=eval\ {\ ..\ };\ if\ ...


XPT whileeach hint=while\ \(\ \(\ key,\ val\ )\ =\ each\(\ %**\ )\ )
while`$SPwhl^(`$SPcnd^(`$SParg^$`key^,`$SPcm^$`val^`$SParg^) = each(`$SParg^%`array^`$SParg^)`$SPcnd^)`$BRwhl^{
    `cursor^
}

XPT whileline hint=while\ \(\ defined\(\ \$line\ =\ <FILE>\ )\ )
while`$SPwhl^(`$SPcnd^defined(`$SParg^$`line^`$SPeq^=`$SPeq^<`STDIN^>`$SParg^)`$SPcnd^)`$BRwhl^{
    `cursor^
}


XPT foreach hint=foreach\ my\ ..\ (..){}
foreach`$SPfor^my $`var^ (`$SPfstm^@`array^`$SPfstm^)`$BRfor^{
    `cursor^
}


XPT forkeys hint=foreach\ my\ var\ \(\ keys\ %**\ )
foreach`$SPfor^my $`var^ (`$SPfstm^keys @`array^`$SPfstm^)`$BRfor^{
    `cursor^
}


XPT forvalues hint=foreach\ my\ var\ \(\ keys\ %**\ )
foreach`$SPfor^my $`var^ (`$SPfstm^values @`array^`$SPfstm^)`$BRfor^{
    `cursor^
}


XPT if hint=if\ (\ ..\ )\ {\ ..\ }\ ...
XSET job=$CS job
if`$SPif^(`$SPcnd^`cond^`$SPcnd^)`$BRif^{
    `job^
}`
`elsif...^`$BRel^elsif`$SPif^(`$SPcnd^`cond2^`$SPcnd^)`$BRif^{
    `job^
}`
`elsif...^`
`else...{{^`$BRel^else`$BRif^{
    `cursor^
}`}}^

XPT package hint=
package `className^;

use base qw(`parent^);

sub new`$BRfun^{
    my $class = shift;
    $class = ref $class if ref $class;
    my $self = bless {}, $class;
    $self;
}

1;

..XPT


" ================================= Wrapper ===================================

XPT if_ hint=if\ (..)\ {\ SEL\ }\ ...
XSET job=$CS job
if`$SPif^(`$SPcnd^`cond^`$SPcnd^)`$BRif^{
    `wrapped^
}`
`elsif...^`$BRel^elsif`$SPif^(`$SPcnd^`cond2^`$SPcnd^)`$BRif^{
    `job^
}`
`elsif...^`
`else...{{^`$BRel^else`$BRif^{
    `cursor^
}`}}^


XPT eval_ hint=eval\ {\ ..\ };if...
eval`$BRif^{
    `wrapped^
};
if`$SPif^(`$SPcnd^$@`$SPcnd^)`$BRif^{
    `handle^
}

XPT try_ alias=eval_ hint=eval\ {\ ..\ };\ if\ ...
