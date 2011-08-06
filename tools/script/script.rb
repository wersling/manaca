#!/usr/bin/env ruby

require 'yaml'
require 'erb'
require 'fileutils'


#生成的代码位置
SOURCE_DIR="src/"

#项目配置文件
CONFIG_FILE="application.xml"

#代码初始包名
PACKAGE=""

#代码初始包路径
SOURCE_PATH=""

#许可
COPYRIGHT="Copyright (c) 2011, wersling.com All rights reserved."
#######################################################
#下面的代码请勿改动
#######################################################

#ruby脚本位置
SCRIPT_DIR="script/"

#模版位置
TEMPLATE_DIR="#{SCRIPT_DIR}templates/"

#模版文件
TRMPLATE_MODULE="Module.as.erb"
TRMPLATE_MODULE_CONTEXT="ModuleContext.as.erb"
TRMPLATE_MODULE_INTERFACE="IModule.as.erb"
TRMPLATE_STRATUP_COMMAND="StartupCommand.as.erb"
TRMPLATE_SHUTDOWN_COMMAND="ShutdownCommand.as.erb"
TRMPLATE_MODULE_MEDIATOR="ModuleMediator.as.erb"
TRMPLATE_RESPONSE_COMMAND="ResponseCommand.as.erb"

TRMPLATE_VIEW="View.as.erb"
TRMPLATE_VIEW_EVENT="ViewEvent.as.erb"
TRMPLATE_VIEW_MEDIATOR="ViewMediator.as.erb"

TEMPLATE_EVENT="Event.as.erb"
TEMPLATE_COMMAND="Command.as.erb"
TEMPLATE_MODULE_COMMAND="ModuleCommand.as.erb"

#Service模版文件
TEMPLATE_SERVICE_DIR="#{SCRIPT_DIR}services/"
SERVICE_FILE_PATH="common/service/"

TEMPLATE_SERVICE="Service.erb"
TEMPLATE_SERVICE_INS="ServiceIns.erb"
TEMPLATE_PARSER="helper/Parser.erb"
TEMPLATE_PARSER_INS="helper/ParserIns.erb"
TEMPLATE_DATA_EVENT="events/DataEvent.erb"
TEMPLATE_PARAM="Param.erb"
TEMPLATE_DATA="vo/Data.erb"

#MVC目录
PROJECT_DIR_MODEL="model/"
PROJECT_DIR_VIEW="view/"
PROJECT_DIR_CONTROLLER="controller/"
PROJECT_DIR_SERVICE="service"
PROJECT_DIR_EVENTS="events/"
PROJECT_DIR_STARTUP="startup/"

#模块定义类
class Module
    attr_accessor :module_name, :file_path, :path_name, :package,:par
end

#模版
class Templates
    attr_reader :output
    
    def initialize(template_name, vars)
        @vars = vars
        @template_filename = template_name
        @copyright = COPYRIGHT
    end
    
    def build 
        template = nil
        begin
            template = ERB.new(open(@template_filename).read(), nil, "%<>", "@output")
            template.result(binding)
        rescue
            $stderr.puts($!)
            raise
        end
    end
end

def generate_template(template_name, output_filename, vars)
    if File.exists?(output_filename)
        puts "EXISTS #{output_filename}"
        return false
    end 
    
    t = Templates.new(template_name, vars)
    t.build 
    open("#{output_filename}", "w") do |f|
        puts "CREATE #{output_filename}"
        f.write(t.output)
    end
    return true
end

def copy_dir(srcdir, directory)
    require 'ftools'
    files = Dir.entries(srcdir)
    Dir.mkdir(directory) unless File.exists?(directory)
    files.each do | file |
        File.copy("#{srcdir}/#{file}", "#{directory}/#{file}") unless File.directory?("#{srcdir}/#{file}")
    end
end

def makedir(dirname)
    unless File.exists?(dirname) 
        FileUtils.mkdir_p(dirname) 
        puts "CREATE #{dirname}"
    else
        puts "EXISTS #{dirname}"
    end
end

def help()
    puts "VERSION:1.2"
    puts "使用方法"
    puts "    1.生成模块代码"
    puts "        命令：ruby script\\script.rb projectName ModuleName create"
    puts "        参数：projectName - 项目名称，首字母小写"
    puts "              ModuleName - 模块名称，首字母大写"
    puts "        可选参数:"
    puts "            s - 模块为一个section"
    puts ""
    puts "    2.生成View代码"
    puts "        命令：ruby script\\script.rb projectName ModuleName view viewName"
    puts "        参数：projectName - 项目名称，首字母小写"
    puts "              ModuleName - 模块名称，首字母大写"
    puts "                viewName - View名称"
    puts ""
    puts "    3.生成Respose代码"
    puts "        命令：ruby script\\script.rb projectName ModuleName res resposeName"
    puts "        参数：projectName - 项目名称，首字母小写"
    puts "              ModuleName - 模块名称，首字母大写"
    puts "              resposeName - respose command 名称"
    puts ""
    puts "    4.生成Command代码"
    puts "        命令：ruby script\\script.rb projectName ModuleName cmd cmdName"
    puts "        参数：projectName - 项目名称，首字母小写"
    puts "              ModuleName - 模块名称，首字母大写"
    puts "             cmdName - Command 名称，省略Command后缀：例如要创建SaveUserInfoCommand，直接写SaveUserInfo"
    puts "        可选参数:"
    puts "            m - Command为一个ModuleCommand"
end

#总命令
#action 动作，分别是create,view,res,cmd
#moduleName 模块名称
#par 参数
def create(action, moduleName, par, par2)
    if action == nil and moduleName == nil
        puts "ERROR you must specify an action and the moduleName of the class"
        return nil
    end
    
    result = case action
        when 'create': create_module(moduleName, par, par2)
        when 'view': create_view(moduleName, par, par2)
        when 'res': create_respose(moduleName, par, par2)
        when 'cmd': create_command(moduleName, par, par2)
        when 'service': create_service(moduleName, par, par2)
    else puts "ERROR: action not supported. Supported actions are command"
    end
end

#生成模块文件
def create_module(module_name, par, par2)
    #配置初始化参数
    @module = Module.new
    @module.par = par
    @module.module_name = module_name
    @module.path_name = "#{@module.module_name[0,1].downcase}#{@module.module_name[1..@module.module_name.length]}"
    @module.package = "#{PROJECT_BASE_PACKAGE}#{@module.path_name}"
    @module.file_path = "#{SOURCE_DIR}#{@project_dir}#{PROJECT_DIR_MODULES}#{@module.path_name}/"
    
    #生成文件夹
    makedir("#{@module.file_path}")
    makedir("#{@module.file_path}#{PROJECT_DIR_MODEL}")
    makedir("#{@module.file_path}#{PROJECT_DIR_VIEW}")
    makedir("#{@module.file_path}#{PROJECT_DIR_CONTROLLER}")
    makedir("#{@module.file_path}#{PROJECT_DIR_CONTROLLER}#{PROJECT_DIR_STARTUP}")
    makedir("#{@module.file_path}#{PROJECT_DIR_SERVICE}")
    
    #生成Module文件
    generate_template("#{TEMPLATE_DIR}/#{TRMPLATE_MODULE}", "#{@module.file_path }#{@module.module_name}Module.as", @module)
    #生成ModuleContext文件
    generate_template("#{TEMPLATE_DIR}/#{TRMPLATE_MODULE_CONTEXT}", "#{@module.file_path }#{@module.module_name}Context.as", @module)
    #生成Module接口文件
    generate_template("#{TEMPLATE_DIR}/#{TRMPLATE_MODULE_INTERFACE}", "#{@module.file_path }I#{@module.module_name}Module.as", @module)
    #生成StartupCommand文件
    generate_template("#{TEMPLATE_DIR}/#{TRMPLATE_STRATUP_COMMAND}", "#{@module.file_path }#{PROJECT_DIR_CONTROLLER}#{PROJECT_DIR_STARTUP}#{@module.module_name}StartupCommand.as", @module)
    #生成ShutdownCommand文件
    generate_template("#{TEMPLATE_DIR}/#{TRMPLATE_SHUTDOWN_COMMAND}", "#{@module.file_path }#{PROJECT_DIR_CONTROLLER}#{PROJECT_DIR_STARTUP}#{@module.module_name}ShutdownCommand.as", @module)
    #生成ModuleMediator文件
    if @module.par.index("m")
        generate_template("#{TEMPLATE_DIR}/#{TRMPLATE_MODULE_MEDIATOR}", "#{@module.file_path }#{PROJECT_DIR_VIEW}#{@module.module_name}ModuleMediator.as", @module)
    end
    
    #更新配置文件
    full_data = read_file("#{SOURCE_DIR}#{CONFIG_FILE}")
    
    #插入Section配置
    if @module.par.index("s")
        index = full_data.index(/<Sections>/)  + 10
        full_data = full_data.insert(index, "\n        <Section name=\"#{@module.path_name}\" path=\"#{@module.path_name}\" moduleName=\"#{@module.module_name}Module\"/>")
    end
    #插入模块配置
    index = full_data.index(/<Modules>/)  + 9
    full_data = full_data.insert(index, "\n        <Module \n			name=\"#{@module.module_name}Module\"\n			clz=\"#{@module.package }::#{@module.module_name}Module\"\n			encoded=\"false\"\n			preloading=\"false\"\n			url=\"#{PROJECT_DIR_MODULES}#{@module.path_name}/#{@module.module_name}Module.swf\"/>")
    
    #插入资源配置
    #index = full_data.index(/<Resources>/)  + 11
    #full_data = full_data.insert(index, "\n        <DLL name=\"#{@module.path_name}\" encoded=\"false\" preloading=\"false\" url=\"#{PROJECT_DIR_MODULES}#{@module.path_name}/#{@module.module_name}Module.swf\"/>")
    
    write_file("#{SOURCE_DIR}#{CONFIG_FILE}", full_data)
    
    create_view(module_name, module_name, par2)
end

def create_view(module_name, view_name, par2)
    #配置初始化参数
    @module = Module.new
    @module.par = view_name
    @module.module_name = module_name
    @module.path_name = "#{@module.module_name[0,1].downcase}#{@module.module_name[1..@module.module_name.length]}"
    @module.package = "#{PROJECT_BASE_PACKAGE}#{@module.path_name}"
    @module.file_path = "#{SOURCE_DIR}#{@project_dir}#{PROJECT_DIR_MODULES}#{@module.path_name}/"
    
    makedir("#{@module.file_path}")
    makedir("#{@module.file_path}#{PROJECT_DIR_VIEW}")
    
    #生成View文件
    generate_template("#{TEMPLATE_DIR}/#{TRMPLATE_VIEW}", "#{@module.file_path }view/#{@module.par}View.as", @module)
    #生成ModuleContext文件
    generate_template("#{TEMPLATE_DIR}/#{TRMPLATE_VIEW_MEDIATOR}", "#{@module.file_path }view/#{@module.par}ViewMediator.as", @module)
    makedir("#{@module.file_path }view/events")
    #生成ViewEvent文件
    generate_template("#{TEMPLATE_DIR}/#{TRMPLATE_VIEW_EVENT}", "#{@module.file_path }view/events/#{@module.par}ViewEvent.as", @module)
    
    #更新配置文件
    startupCommand = "#{@module.file_path }#{PROJECT_DIR_CONTROLLER}#{PROJECT_DIR_STARTUP}#{@module.module_name}StartupCommand.as"
    full_data = read_file(startupCommand)
    
    #插入位置
    index = full_data.index("// view")  + 7
    #插入mapView
    full_data = full_data.insert(index, "\n        mediatorMap.mapView(#{@module.par}View, #{@module.par}ViewMediator);")
    index = full_data.index("import ")  - 1
    #插入import
    full_data = full_data.insert(index, "\nimport #{@module.package}.view.#{@module.par}View;\nimport #{@module.package}.view.#{@module.par}ViewMediator;")
    write_file(startupCommand, full_data)
    puts "update : "  + startupCommand
end

def create_respose(module_name, response, par2)
    #配置初始化参数
    @module = Module.new
    @module.par = response
    @module.module_name = module_name
    @module.path_name = "#{@module.module_name[0,1].downcase}#{@module.module_name[1..@module.module_name.length]}"
    @module.package = "#{PROJECT_BASE_PACKAGE}#{@module.path_name}"
    @module.file_path = "#{SOURCE_DIR}#{@project_dir}#{PROJECT_DIR_MODULES}#{@module.path_name}/"
    
    #生成Response command文件
    generate_template("#{TEMPLATE_DIR}/#{TRMPLATE_RESPONSE_COMMAND}", "#{@module.file_path }controller/#{@module.par}ResponseCommand.as", @module)
end

def create_command(module_name, cmd, par2)
    #配置初始化参数
    @module = Module.new
    @module.par = cmd
    @module.module_name = module_name
    @module.path_name = "#{@module.module_name[0,1].downcase}#{@module.module_name[1..@module.module_name.length]}"
    @module.package = "#{PROJECT_BASE_PACKAGE}#{@module.path_name}"
    @module.file_path = "#{SOURCE_DIR}#{@project_dir}#{PROJECT_DIR_MODULES}#{@module.path_name}/"
    
    #生成Command文件
    if par2.index("m")
        generate_template("#{TEMPLATE_DIR}/#{TEMPLATE_MODULE_COMMAND}", "#{@module.file_path }controller/#{@module.par}Command.as", @module)
    else
        generate_template("#{TEMPLATE_DIR}/#{TEMPLATE_COMMAND}", "#{@module.file_path }controller/#{@module.par}Command.as", @module)
    end
    #makedir("#{@module.file_path }controller/events")
    #生成Event文件
    #generate_template("#{TEMPLATE_DIR}/#{TEMPLATE_EVENT}", "#{@module.file_path }controller/events/#{@module.par}Event.as", @module)
end

def create_service(service_name, cmd, par2)
    #配置初始化参数
    @module = Module.new
    @module.par = cmd
    @module.module_name = service_name
    @module.path_name = "#{@module.par[0,1].downcase}#{@module.par[1..@module.par.length]}"
    @module.package = "common.service.#{@module.path_name}"
    @module.file_path = "#{SOURCE_DIR}#{@project_dir}#{SERVICE_FILE_PATH}#{@module.path_name}/"
    
    makedir("#{@module.file_path}")
    makedir("#{@module.file_path}/vo")
    makedir("#{@module.file_path}/helper")
    makedir("#{@module.file_path}/events")
    #生成Service接口文件
    generate_template("#{TEMPLATE_SERVICE_DIR}/#{TEMPLATE_SERVICE}", "#{@module.file_path }#{@module.par}Service.as", @module)
    #生成Service接口实现文件
    generate_template("#{TEMPLATE_SERVICE_DIR}/#{TEMPLATE_SERVICE_INS}", "#{@module.file_path }#{@module.par}ServiceIns.as", @module)
    
    generate_template("#{TEMPLATE_SERVICE_DIR}/#{TEMPLATE_PARSER}", "#{@module.file_path }helper/#{@module.par}Parser.as", @module)
    generate_template("#{TEMPLATE_SERVICE_DIR}/#{TEMPLATE_PARSER_INS}", "#{@module.file_path }helper/#{@module.par}ParserIns.as", @module)
    generate_template("#{TEMPLATE_SERVICE_DIR}/#{TEMPLATE_DATA_EVENT}", "#{@module.file_path }events/#{@module.par}DataEvent.as", @module)
    generate_template("#{TEMPLATE_SERVICE_DIR}/#{TEMPLATE_PARAM}", "#{@module.file_path }#{@module.par}Param.as", @module)
    generate_template("#{TEMPLATE_SERVICE_DIR}/#{TEMPLATE_DATA}", "#{@module.file_path }vo/#{@module.par}Data.as", @module)
end

def read_file(file_name) 
    data = ""
    File.open(file_name).each { |line| data += line }
    return data
end

def write_file(file_name, data) 
    File.chmod(0666, file_name)
    File.open(file_name, "w") { |f| f.puts data }
end

#run as runable script
# project moduleName cmd par
if $0 == __FILE__
    raise "usage #{File.basename(__FILE__)}" unless ARGV.length >= 1
    
    if ARGV[0] != nil
        project = ARGV[0]
    end
    
    if project != "help"
        if project == ""
            PROJECT_DIR_MODULES="#{SOURCE_PATH}modules/"
            PROJECT_BASE_PACKAGE="#{PACKAGE}modules."
        else
            PROJECT_DIR_MODULES="#{SOURCE_PATH}#{project}/modules/"
            PROJECT_BASE_PACKAGE="#{PACKAGE}#{project}.modules."
        end
    end
    
    if ARGV[1] != nil
        moduleName = ARGV[1]
    end
    
    if ARGV[2] != nil
        action = ARGV[2]
    end
    
    if ARGV[3] != nil
        par=ARGV[3]
    else
        par=""
    end
    
    if ARGV[4] != nil
        par2=ARGV[4]
    else
        par2=""
    end
    
    result = case project 
        when 'help': help()
    else create(action, moduleName, par, par2)
    end
end