class Node
	
	attr_accessor :previous_node, :value, :next_nodes
	
	def initialize(value, link = false)
		@value = value if value[0].between?(0, 7) && value[1].between?(0, 7)
		@next_nodes = []
		create_links if link
	end
	
	def to_s
		value.inspect
	end
	
	def add(node)
		node.previous_node = self
		self.next_nodes << node unless node.value.nil?
	end
	
	def create_links
		x, y = value
		self.add self.class.new([x+2, y+1])
		self.add self.class.new([x+2, y-1])
		self.add self.class.new([x-2, y+1])
		self.add self.class.new([x-2, y-1])
		self.add self.class.new([x+1, y+2])
		self.add self.class.new([x+1, y-2])
		self.add self.class.new([x-1, y+2])
		self.add self.class.new([x-1, y-2])
	end
	
	def find_path(x, y)
		queue = [self]
		loop do
			break if queue.empty?
			node = queue.pop
			
			return node if node.value == [x, y]
			node.create_links
			
			node.next_nodes.each do |n|
				queue.unshift(n)
			end
			
		end
	end
	
end

node = Node.new([3, 3])
#p node
path = node.find_path(3, 4)
puts path

until path.previous_node.nil? do
	path = path.previous_node
	puts path
end
#p node