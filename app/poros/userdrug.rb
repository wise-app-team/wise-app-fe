class Userdrug
  attr_accessor :id,
                :user_id, 
                :drug_id,
                :dose1,
                :dose2,
                :dose3,
                :prn,
                :notes

  def initialize(data)
    @id = data[:id]
    @user_id = data[:user_id]
    @drug_id = data[:drug_id]
    @dose1 = data[:dose1]
    @dose2 = data[:dose2]
    @dose3 = data[:dose3]
    @prn = data[:prn]
    @notes = data[:notes]
  end
end