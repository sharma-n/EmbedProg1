%
% Program for testing the mini ARM
%
% It should stop by looping at address 0x0020 (label 'end')
% If it stops at another address, there is a bug...
%
        mov r0,#5       % load 5 into r0
        str r0, var     % store 5 in var
        ldr r1, var     % load var into r2
        cmp r1,r0       % did we read the same value?
        beq okls
@errls  b errls         % no => loop here
@okls   add r2,r1,r1    % r2 <- 2*r1
        cmp r2,r1       % is r2 < r1
        blt err1        % yes => error
        b ok1           % no, continue
@err1   b err1          % loop here
@ok1    cmp r1,#5       % is r1 = 5
        beq ok2         % yes, it's ok
@err2   b err2          % no => error, loop here
@ok2    sub r3,r1,r2    % r3 <- r1-r2
        cmp r3,#0       % is r3 < 0
        blt end         % yes => ok
@err3   b err3          % no => error, loop here
@end    b end           % end of program, loop here
 
@var    rmw 1           % reserve a word for a variable
