# coding: utf-8

require "pp"
require "spec_helper"

describe Megalopolis, "が #get, :log => 100 を呼ぶ時は" do
  before do
    m = Megalopolis.new("http://coolier.sytes.net/sosowa/ssw_l/")
    @s = m.get :log => 100
  end
  
  it "Megalopolis::Subjectを返すこと" do
    @s.class.should == Megalopolis::Subject
  end

  it "最初のノベルはMegalopolis::Indexであること" do
    @s.first.class.should == Megalopolis::Index
  end

  it "最初のタイトルがStringであること" do
    @s.first.title.class.should == String
  end

  it "#next_pageがMegalopolis::Subjectを返すこと" do
    @s.next_page.class.should == Megalopolis::Subject
  end

  it "#prev_pageがMegalopolis::Subjectを返すこと" do
    @s.next_page.prev_page.class.should == Megalopolis::Subject
  end

  it "#latest_logがFixnumを返すこと" do
    @s.latest_log.class.should == Fixnum
  end

  it "最初を#fetchしたらMegalopolis::Novelを返すこと" do
    @s.first.fetch.class.should == Megalopolis::Novel
  end

  it "最初を#fetchしたMegalopolis::Novel#entry#titleがStringなこと" do
    @s.first.fetch.entry.title.class.should == String
  end

  it "直接Novelを取得出来ること" do
    log = @s.first.log
    key = @s.first.key
    m = Megalopolis.new("http://coolier.sytes.net/sosowa/ssw_l/")
    novel = m.get :log => log, :key => key
    novel.class.should == Megalopolis::Novel
  end
end
