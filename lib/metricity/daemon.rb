module Metricity
  # Daemon
  module Daemon
    PID_FILE = '/tmp/metricitiy.pid'
    ACTIONS = [:start, :run, :stop, :status, :version]

    # Setup
    def self.setup(args)
      if args.empty?
        puts 'Metricity Help'
      else
        send(args.first.to_sym) if ACTIONS.include? args.first.to_sym
      end
    end

    # Run
    def self.run
      trap_signals
      puts 'Metricity Client ' + Metricity::VERSION
      puts ':: Starting..'
      @keep_running = true
      while @keep_running
        Metricity.init
        puts 'Metrics send!'
        sleep(10)
      end
    end

    # Start
    def self.start
      pid = load_pid
      check_pid(pid)
      pid = fork { run }
      detach_process(pid)
    end

    # Stop
    def self.stop
      pid = load_pid
      if pid != 0
        # Gracefully shutdown
        Process.kill('QUIT', pid.to_i)
        File.delete(PID_FILE)
        puts ':: Stopping Metricity Client'
      else
        puts 'No Daemon was running'
      end
    end

    # Version
    def self.version
      puts Metricity::VERSION
    end

    # Status
    def self.status
      pid = load_pid
      if pid != 0
        puts ':: Metricity Client is running'
      else
        puts ':: Metricity Client is not running'
      end
    end

    private

    # Load PID
    def self.load_pid
      pid = 0
      if File.exist?(PID_FILE)
        file = File.new(PID_FILE, 'r')
        pid = file.read
        file.close
      end
      pid
    end

    # Check PID
    def self.check_pid(pid)
      if pid != 0
        warn 'Metricity Client is already running'
        exit
      end
    end

    # Detach process
    def self.detach_process(pid)
      file = File.new(PID_FILE, 'w')
      file.write(pid)
      file.close
      Process.detach(pid)
      rescue => exc
        Process.kill('TERM', pid)
        warn "Cannot start daemon: #{exc.message}"
    end

    # Trap signals
    def self.trap_signals
      trap 'SIGINT' do
        puts 'Exiting'
        exit 130
      end
    end
  end
end
