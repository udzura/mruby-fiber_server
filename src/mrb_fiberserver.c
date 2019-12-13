/*
** mrb_fiberserver.c - FiberServer class
**
** Copyright (c) Uchio Kondo 2019
**
** See Copyright Notice in LICENSE
*/

#include <fcntl.h>
#include <signal.h>
#include <mruby.h>
#include "mrb_fiberserver.h"

#define DONE mrb_gc_arena_restore(mrb, 0);


static mrb_value mrb_fiberserver_fcntl(mrb_state *mrb, mrb_value self)
{
  mrb_int fd, arg0, arg1;
  mrb_get_args(mrb, "iii", &fd, &arg0, &arg1);

  return mrb_fixnum_value(fcntl((int)fd, (int)arg0, (int)arg1));
}

static mrb_value mrb_fiberserver_sigpipe_ign(mrb_state *mrb, mrb_value self)
{
  signal(SIGPIPE, SIG_IGN);
  return mrb_true_value();
}

void mrb_mruby_fiber_server_gem_init(mrb_state *mrb)
{
  struct RClass *fiberserver;
  fiberserver = mrb_define_class(mrb, "FiberServer", mrb->object_class);
  mrb_define_class_method(mrb, fiberserver, "fcntl", mrb_fiberserver_fcntl, MRB_ARGS_REQ(3));
  mrb_define_class_method(mrb, fiberserver, "sigpipe_ign!", mrb_fiberserver_sigpipe_ign, MRB_ARGS_NONE());
  DONE;
}

void mrb_mruby_fiber_server_gem_final(mrb_state *mrb)
{
}
