#!/bin/bash
gdc -fdoc -c -fsyntax-only ../modules/*.d -fdoc-inc=candydoc/candy.ddoc -fdoc-inc=candydoc/modules.ddoc -I ../modules
