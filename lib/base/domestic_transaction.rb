require 'rubygems'
require 'builder'
require 'httmultiparty'
require 'tempfile'

class DomesticTransaction

  attr_accessor :account_from, :currency, :amount, :account_to, :bank_code, :ks, :vs, :ss, :date, :message_for_recipient, :comment, :payment_type

  def initialize(options={})
    @account_from = options[:account_from]
    @currency = options[:currency]
    @amount = options[:amount]
    @account_to = options[:account_to]
    @bank_code = options[:bank_code]
    @ks = options[:ks]
    @vs = options[:vs]
    @ss = options[:ss]
    @date = options[:date]
    @message_for_recipient = options[:message_for_recipient]
    @comment = options[:comment]
    @payment_type = options[:payment_type] || "431001"
  end

  def import
    file = Tempfile.new('fio')
    
    xml = Builder::XmlMarkup.new(:target=>file, :indent=>2)
    xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"
    xml.tag!('Import', {"xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance", "xsi:noNamespaceSchemaLocation"=>"http://www.fio.cz/schema/importIB.xsd"}) do |import|
      import.tag!("Orders") do |order|
        order.tag!("DomesticTransaction") do |transaction|
      	order.tag!("accountFrom",         @account_from)
      	order.tag!("currency",            @currency)
      	order.tag!("amount",              @amount)
      	order.tag!("accountTo",           @account_to)
      	order.tag!("bankCode",            @bank_code)
      	order.tag!("ks",                  @ks)
      	order.tag!("vs",                  @vs)
      	order.tag!("ss",                  @ss)
      	order.tag!("date",                @date)
      	order.tag!("messageForRecipient", @message_for_recipient)
      	order.tag!("comment",             @comment)
      	order.tag!("paymentType",         @payment_type)
        end
      end
    end

    file.rewind

    FioAPI::Request.post("/import/", :query=>{:type=>'xml',
      :token=>FioAPI.token,
      :file=>file}
    )
  end
end

