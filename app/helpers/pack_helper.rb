module PackHelper
  def cards_count(pack_id)
    current_user.cards.where('pack_id = ?', pack_id).count
  end
end
