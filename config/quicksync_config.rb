$default_config = 
	{
	  :run_method => :generate,
		:settings => {
	 		:ssh_app => 	"rsh",
	 		:rsync_app => 	"rsync",
	 		:log_file =>	"",
	 		:verbose =>		true,
	 		:silent =>		false,
	 	},
		:from => {
	 		:host => 	"",
	 		:user => 	"",
	 		:dir =>   "/users/shaun/Dropbox/dtg/development/mgm-sugarcrm/data",
		},
		:to => {
	 		:host => 	"staging.crm.mgmwireless.com",
	 		:user => 	"sugarcrm",
	 		:dir => 	"/cygdrive/c/inetpub/wwwroot/SugarCRM-main/staging/current/data",
		},
		:exclude => %w(.DS_Store .log .csv mytest.txt),
		:include => %w(),
		:copy_options => %w(progress stats times perms compress),
	}
	
