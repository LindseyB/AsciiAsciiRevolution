#!/bin/bash
dmd -D -c -o- ../modules/*.d candydoc/candy.ddoc candydoc/modules.ddoc
