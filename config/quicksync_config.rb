$default_options = 
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
	 		:host => 	"local",
	 		:user => 	"",
	 		:dir =>   "/users/shaun/Dropbox/dtg/development/mgm-sugarcrm/data",
		},
		:to => {
	 		:host => 	"dev.crm.mgmwireless.com",
	 		:user => 	"sugarcrm",
	 		:dir => 	"/inetpub/wwwroot/SugarCRM-main/dev/current/data",
		},
		:exclude => %w(.DS_Store .log .csv mytest.txt),
		:include => %w(),
		:copy_options => %w(progress stats times perms compress dry-run),
	}
	
