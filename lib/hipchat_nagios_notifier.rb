require "thor"
require "hipchat-api"
require "socket"

module HipchatNagiosNotifier
  class CLI < Thor
    COLORS = {
      'PROBLEM'           =>'red',
      'RECOVERY'          =>'green',
      'ACKNOWLEDGEMENT'   =>'green',
      'FLAPPINGSTART'     =>'orange',
      'FLAPPINGSTOP'      =>'green',
      'FLAPPINGDISABLED'  =>'gray',
      'DOWNTIMESTART'     =>'red',
      'DOWNTIMESTOP'      =>'green',
      'DOWNTIMECANCELLED' =>'green'
    }

    desc "service api_key room from details", "Notify about a service."
    def service(api_key, room, from, details)
      nagioshost = Socket.gethostname.split('.')[0]
      servicedesc, hostalias,timestamp,type,hostaddress,servicestate,serviceoutput = details.split('|')
      color = COLORS[type] || 'gray'

      notify api_key, room, from, color, %{#{timestamp} - #{servicedesc} is #{servicestate} on #{hostaddress}: #{serviceoutput}}
    end

    desc "host api_key room from details", "Notify about a host."
    def host(api_key, room, from, details)
      nagioshost = Socket.gethostname.split('.')[0]
      hostname,timestamp,type,hostaddress,hoststate,hostoutput = details.split('|')
      color = COLORS[type] || 'gray'

      notify api_key, room, from, color, %{#{timestamp} - Host #{hostname}  (Origin: nagios@#{nagioshost})
  Details:
          Notification type: #{type}
          Host: #{hostname} (Address #{hostaddress})
          State: #{hoststate}
          Info:
          #{hostoutput}
  ---------}.gsub("\n", "<br/>")
    end

    private
      def notify(api_key, room, from, color, message)
        connection(api_key).rooms_message(room, from, message.strip, true, color)
      end

      def connection(api_key)
        begin
          HipChat::API.new(api_key)
        rescue Exception => e
          $stderr.puts "Error connecting to HipChat: "+e.inspect
          exit(1)
        end
      end
  end
end
