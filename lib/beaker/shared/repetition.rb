module Beaker
  module Shared
    module Repetition

      def repeat_for seconds, &block
        timeout = Time.now + seconds
        done = false
        until done or timeout < Time.now do
          done = block.call
          sleep 1 # do not peg CPU if &block took less than 1 second
        end
        return done
      end

      def repeat_for_and_wait seconds, wait, &block
        timeout = Time.now + seconds
        done = false
        until done or timeout < Time.now do
          done = block.call
          sleep wait unless done
        end
        return done
      end

      def repeat_fibonacci_style_for attempts, &block
        done = false
        attempt = 1
        last_wait, wait = 0, 1
        while not done and attempt <= attempts do
          done = block.call
          attempt += 1
          sleep wait unless done
          last_wait, wait = wait, last_wait + wait
        end
        return done
      end
    end
  end
end

