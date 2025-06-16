%ifndef __ARGS_CONTAINER_INTERNAL_INC__
%define __ARGS_CONTAINER_INTERNAL_INC__

struc args_container_t
  .options_list: resq 1
  .argv:         resq 1
  .argc:         resd 1
  .index:        resd 1
endstruc

%endif
