class Message < ApplicationRecord
	after_create_commit { PublicMessageBrodcastJob.perform_later self }
end
