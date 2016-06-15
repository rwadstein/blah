require 'spec_helper'

RSpec.describe HashKit::Helper do
  describe '#symbolize' do

    context 'when a single layer hash with string keys is specified' do
      let(:hash) { { 'key1' => 'value1', 'key2' => 'value2' } }

      it 'should return a hash with symbolized keys' do
        new_hash = subject.symbolize(hash)
        expect(new_hash.has_key?('key1')).to be_falsey
        expect(new_hash.has_key?('key2')).to be_falsey
        expect(new_hash.has_key?(:key1)).to be_truthy
        expect(new_hash.has_key?(:key2)).to be_truthy
      end
    end

    context 'when a single layer hash with symbol keys is specified' do
      let(:hash) { { :key1 => 'value1', :key2 => 'value2' } }

      it 'should return a hash with symbolized keys' do
        new_hash = subject.symbolize(hash)
        expect(new_hash.has_key?(:key1)).to be_truthy
        expect(new_hash.has_key?(:key2)).to be_truthy
      end
    end

    context 'when a hash with a nested hash is specified' do
      let(:hash) { { 'key1' => 'value1', 'key2' => 'value2', 'key3' => { 'key4' => 'value4' } } }

      it 'should return a hash with symbolized keys' do
        new_hash = subject.symbolize(hash)
        expect(new_hash.has_key?('key1')).to be_falsey
        expect(new_hash.has_key?('key2')).to be_falsey
        expect(new_hash.has_key?('key3')).to be_falsey
        expect(new_hash.has_key?(:key1)).to be_truthy
        expect(new_hash.has_key?(:key2)).to be_truthy
        expect(new_hash.has_key?(:key3)).to be_truthy

        expect(new_hash[:key3].has_key?('key4')).to be_falsey
        expect(new_hash[:key3].has_key?(:key4)).to be_truthy
      end
    end

    context 'when a hash with an array of nested hashes is specified' do
      let(:hash) { { 'key1' => 'value1', 'key2' => 'value2', 'key3' => [{ 'key4' => 'value4' }, { 'key4' => 'value4' }]} }

      it 'should return a hash with symbolized keys' do
        new_hash = subject.symbolize(hash)
        expect(new_hash.has_key?('key1')).to be_falsey
        expect(new_hash.has_key?('key2')).to be_falsey
        expect(new_hash.has_key?('key3')).to be_falsey
        expect(new_hash.has_key?(:key1)).to be_truthy
        expect(new_hash.has_key?(:key2)).to be_truthy
        expect(new_hash.has_key?(:key3)).to be_truthy

        expect(new_hash[:key3][0].has_key?('key4')).to be_falsey
        expect(new_hash[:key3][0].has_key?(:key4)).to be_truthy
        expect(new_hash[:key3][1].has_key?('key4')).to be_falsey
        expect(new_hash[:key3][1].has_key?(:key4)).to be_truthy
      end
    end

  end

  describe '#stringify' do

    context 'when a single layer hash with symbol keys is specified' do
      let(:hash) { { :key1 => 'value1', :key2 => 'value2' } }

      it 'should return a hash with stringified keys' do
        new_hash = subject.stringify(hash)
        expect(new_hash.has_key?('key1')).to be true
        expect(new_hash.has_key?('key2')).to be true
        expect(new_hash.has_key?(:key1)).to be false
        expect(new_hash.has_key?(:key2)).to be false
      end
    end

    context 'when a single layer hash with string keys is specified' do
      let(:hash) { { 'key1' => 'value1', :'key2' => 'value2' } }

      it 'should return a hash with stringified keys' do
        new_hash = subject.stringify(hash)
        expect(new_hash.has_key?('key1')).to be true
        expect(new_hash.has_key?('key2')).to be true
      end
    end

    context 'when a hash with a nested hash is specified' do
      let(:hash) { { :key1 => 'value1', :key2 => 'value2', :key3 => { :key4 => 'value4' } } }

      it 'should return a hash with stringified keys' do
        new_hash = subject.stringify(hash)
        expect(new_hash.has_key?('key1')).to be true
        expect(new_hash.has_key?('key2')).to be true
        expect(new_hash.has_key?('key3')).to be true
        expect(new_hash.has_key?(:key1)).to be false
        expect(new_hash.has_key?(:key2)).to be false
        expect(new_hash.has_key?(:key3)).to be false

        expect(new_hash['key3'].has_key?('key4')).to be true
        expect(new_hash['key3'].has_key?(:key4)).to be false
      end
    end

    context 'when a hash with an array of nested hashes is specified' do
      let(:hash) { { :key1 => 'value1', :key2 => 'value2', :key3 => [{ :key4 => 'value4' }, { :key4 => 'value4' }]} }

      it 'should return a hash with stringified keys' do
        new_hash = subject.stringify(hash)
        expect(new_hash.has_key?('key1')).to be true
        expect(new_hash.has_key?('key2')).to be true
        expect(new_hash.has_key?('key3')).to be true
        expect(new_hash.has_key?(:key1)).to be false
        expect(new_hash.has_key?(:key2)).to be false
        expect(new_hash.has_key?(:key3)).to be false

        expect(new_hash['key3'][0].has_key?('key4')).to be true
        expect(new_hash['key3'][0].has_key?(:key4)).to be false
        expect(new_hash['key3'][1].has_key?('key4')).to be true
        expect(new_hash['key3'][1].has_key?(:key4)).to be false
      end
    end

  end
end