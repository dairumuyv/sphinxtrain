#!/usr/bin/perl -w
## ====================================================================
##
## Copyright (c) 1996-2000 Carnegie Mellon University.  All rights 
## reserved.
##
## Redistribution and use in source and binary forms, with or without
## modification, are permitted provided that the following conditions
## are met:
##
## 1. Redistributions of source code must retain the above copyright
##    notice, this list of conditions and the following disclaimer. 
##
## 2. Redistributions in binary form must reproduce the above copyright
##    notice, this list of conditions and the following disclaimer in
##    the documentation and/or other materials provided with the
##    distribution.
##
## 3. The names "Sphinx" and "Carnegie Mellon" must not be used to
##    endorse or promote products derived from this software without
##    prior written permission. To obtain permission, contact 
##    sphinx@cs.cmu.edu.
##
## 4. Products derived from this software may not be called "Sphinx"
##    nor may "Sphinx" appear in their names without prior written
##    permission of Carnegie Mellon University. To obtain permission,
##    contact sphinx@cs.cmu.edu.
##
## 5. Redistributions of any form whatsoever must retain the following
##    acknowledgment:
##    "This product includes software developed by Carnegie
##    Mellon University (http://www.speech.cs.cmu.edu/)."
##
## THIS SOFTWARE IS PROVIDED BY CARNEGIE MELLON UNIVERSITY ``AS IS'' AND 
## ANY EXPRESSED OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, 
## THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
## PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL CARNEGIE MELLON UNIVERSITY
## NOR ITS EMPLOYEES BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
## SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
## LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, 
## DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY 
## THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT 
## (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE 
## OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
##
## ====================================================================
##
## Author: Ricky Houghton (converted from scripts by Rita Singh)
##


require "/sphx_train/testing/scripts_pl/sphinx_train.cfg";


#*******************************************************************
#*******************************************************************

die "USAGE: $0 <iter>" if ($#ARGV != 0);

$iter = $ARGV[0];

# cover up to 100 different buffer directories....
#$buffer_dirs = ($base_dir/bwaccumdir/${exptname}_buff_? $base_dir/bwaccumdir/${exptname}_buff_??);
@buffer_dirs = (<$CFG_BASE_DIR/bwaccumdir/${CFG_EXPTNAME}_buff_*>); # Catches any number of them

$hmm_dir           = "$CFG_BASE_DIR/model_parameters/${CFG_EXPTNAME}.ci_semi_$CFG_N_TIED_STATES";
mkdir ($hmm_dir,0777) unless -d $hmm_dir;

#new models to be produced after normalization
$mixwfn         = "$hmm_dir/mixture_weights";
$tmatfn         = "$hmm_dir/transition_matrices";
$meanfn         = "$hmm_dir/means";
$varfn          = "$hmm_dir/variances";


$logdir   = "$CFG_LOG_DIR/07.cd-schmm";
mkdir ($logdir,0777) unless -d $logdir;
$logfile  = "$logdir/${CFG_EXPTNAME}.$iter.norm.log";

$NORM   = "$CFG_BIN_DIR/norm";

print "$NORM -accumdir @buffer_dirs -mixwfn $mixwfn -tmatfn $tmatfn -meanfn $meanfn -varfn $varfn -feat $CFG_FEATURE -ceplen  $CFG_VECTOR_LENGTH  2> $logfile";

system ("$NORM -accumdir @buffer_dirs -mixwfn $mixwfn -tmatfn $tmatfn -meanfn $meanfn -varfn $varfn -feat $CFG_FEATURE -ceplen  $CFG_VECTOR_LENGTH  2>&1 > $logfile");
`date >> $logfile`;

exit 0