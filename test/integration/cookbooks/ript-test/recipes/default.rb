#
# Cookbook Name:: prosody-test
# Recipe:: default
#

include_recipe 'ript'

# ript_rule 'allow ssh from office' do
#   ript do
#     label 'office', :address => '127.0.0.121'
#     accept 'office' do
#       from 'office'
#       ports 22
#     end
#   end
# end
# 
