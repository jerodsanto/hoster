class Hosts

  attr_reader :entries

  def initialize(hosts_path = "/etc/hosts")
    @hosts_path = hosts_path
    @entries    = extract_entries
  end

  def dump
    File.open(@hosts_path,"r") { |f| f.read }
  end

  def add(host, ip_address = "127.0.0.1")
    @entries[ip_address] << host
  end

  def remove(host, ip_address)
    @entries[ip_address].delete_if { |x| x == host }
  end

  def write_changes!
    @entries.each do |entry|
      append_this     = true
      entry_exists    = false

      File.open(@hosts_path,"r+") do |file|
        lines = file.readlines
        lines.each_with_index do |line,index|
          if line =~ /#{entry.first}/
            if entry_exists
              lines.delete_at(index)
            else
              lines[index] = "#{entry.first} #{entry.last.join(' ')}\n"
              # update the state of this entry
              append_this  = false
              entry_exists = true
            end
          end
        end
        if append_this
          # append entry to end of @hosts_file
        end
        # write out actual changes
        file.pos = 0
        file.print lines
        file.truncate(file.pos)
      end
    end
  end

  private

  def extract_entries
    entries = Hash.new
    File.open(@hosts_path,"r").each do |line|
      if line =~ /^(\d+\.\d+\.\d+\.\d) (.*)/
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

  def condense!
    File.open(@hosts_path,"r+")
  end

end