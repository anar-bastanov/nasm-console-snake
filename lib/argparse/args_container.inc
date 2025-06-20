%ifndef __ARGS_CONTAINER_INC__
%define __ARGS_CONTAINER_INC__

STRUC args_container_t
    .option_list:       resq 1
    .argv:               resq 1
    .option_list_count: resd 1
    .argc:               resd 1
    .index:              resd 1
ENDSTRUC

%endif
