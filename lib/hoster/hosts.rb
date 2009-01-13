class Hosts

  attr_reader :entries
  
  def initialize(hosts_path = "/etc/hosts")
    @hosts_file = File.new(hosts_path,"r+")
    @entries    = extract_entries(hosts_path)
  end
  
  def raw_data
    @hosts_file.read
  end
  
  def add(host, ip_address = "127.0.0.1")
    @entries[ip_address] << host
  end
  
  def remove(host, ip_address)
    @entries[ip_address].delete_if { |x| x == host }
  end
  
  def finalize_changes!
    lines = @hosts_file.readlines
    @entries.each do |entry|
      exists_in_file = false
      lines.each_with_index do |line,index|
        if line.match(/#{entry.first}/)
          exists_in_file = true
          lines[index] = "#{entry.first} #{entry.last.join(' ')}\n"
        end
      end
      if !exists_in_file
        # append entry to end of @hosts_file
      end
      # write out actual changes
      @hosts_file.pos = 0
      @hosts_file.print lines
      @hosts_file.truncate(@hosts_file.pos)
    end
  end
  
  private
  
  def extract_entries(hosts_path)
    entries = Hash.new
    @hosts_file.each do |line|
      if line.match(/^(\d+\.\d+\.\d+\.\d) (.*)/)
        ip_address = $1
        hosts_list = $2.split(' ')
        
        if entries.has_key?(ip_address)
          hosts_list.each do |host|
            entries[ip_address] << host
          end
        else
          entries[ip_address] = hosts_list
        end
      end
    end
    entries
  end
  
end