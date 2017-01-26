class Node
	
	attr_accessor :previous_node, :value, :next_nodes
	
	def initialize(x, y, link = false)
		@value = [x, y] if x.between?(0, 7) && y.between?(0, 7)
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

		[1,2].each do |a|
			[1,2].each do |b|
				[-1,1].each do |a_sign|
					[-1,1].each do |b_sign|
						next if a == b
						self.add self.class.new(x + a * a_sign, y + b * b_sign)
					end
				end
			end
		end

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

def knight_travails(start_point, end_point)
	output = []
 
	path = Node.new(*start_point).find_path(*end_point)
	
	output << path.value
	until path.previous_node.nil? do
		path = path.previous_node
		output << path.value
	end
	count = output.count - 1
	puts "You made it in #{count} moves! Here's your path:"
	output.reverse.each do |point| 
		p point
	end
end

knight_travails([3,3],[0,0])