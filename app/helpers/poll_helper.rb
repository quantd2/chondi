module PollHelper
  def visualize_votes_for(option)
    content_tag :div, class: 'progress' do
      content_tag :div, class: 'progress-bar',
                  style: "width: #{option.poll.normalized_votes_for(option)}%" do
        "#{option.reputation_for(:votes)}"
      end
    end
  end

  def visualize_vote_all_options(options)
    all_stats ||= []
    options.each do |option|
      stats = content_tag :div, class: 'progress' do
        content_tag :div, class: 'progress-bar',
                    style: "width: #{option.poll.normalized_votes_for(option)}%" do
          "#{option.reputation_for(:votes)}"
        end
      end
      all_stats.push raw stats.to_s
    end
    puts all_stats
    return all_stats
  end

  def option_name_display name
    request.path_info.include?("poll") ? name : truncate(name, length: 10)
  end
end
