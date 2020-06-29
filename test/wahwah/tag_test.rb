# frozen_string_literal: true

require 'test_helper'

class WahWah::TagTest < Minitest::Test
  class SubTag < WahWah::Tag; end

  class SubTagWithParse < WahWah::Tag
    def parse; end
  end

  def test_sub_class_not_implemented_parse_method
    assert_raises(WahWah::WahWahNotImplementedError) do
      SubTag.new('test/files/id3v1.mp3')
    end
  end

  def test_have_necessary_attributes_method
    tag = SubTagWithParse.new('test/files/id3v1.mp3')

    assert_respond_to tag, :title
    assert_respond_to tag, :artist
    assert_respond_to tag, :album
    assert_respond_to tag, :albumartist
    assert_respond_to tag, :composer
    assert_respond_to tag, :comments
    assert_respond_to tag, :track
    assert_respond_to tag, :track_total
    assert_respond_to tag, :duration
    assert_respond_to tag, :file_size
    assert_respond_to tag, :genre
    assert_respond_to tag, :year
    assert_respond_to tag, :disc
    assert_respond_to tag, :disc_total
    assert_respond_to tag, :images
    assert_respond_to tag, :sample_rate
  end

  def test_initialized_attributes
    tag = SubTagWithParse.new('test/files/id3v1.mp3')

    assert_equal File.size('test/files/id3v1.mp3'), tag.file_size
    assert_equal [], tag.comments
    assert_equal [], tag.images
  end

  def test_inspect
    tag_inspect = SubTagWithParse.new('test/files/id3v1.mp3').inspect

    assert_includes tag_inspect, 'sample_rate='
    assert_includes tag_inspect, 'bitrate='
  end
end
