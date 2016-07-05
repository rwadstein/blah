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

  describe '#to_hash' do

    let(:key1) do
      { key1: 'value1' }
    end

    let(:key2) do
      { key2: 'value2' }
    end

    let(:child_entity) do
      TestEntity.new.tap do |entity|
        entity.text = 'abc'
        entity.numeric = 5
        entity.time = Time.now
      end
    end

    let(:parent_entity) do
      TestEntity.new.tap do |entity|
        entity.text = 'abc'
        entity.numeric = 5
        entity.time = Time.now
        entity.hash = key1
        entity.hash_array = [key1, key2]
        entity.entity = child_entity
        entity.entity_array = [child_entity, child_entity]
      end
    end

    context 'single layer entity' do
      it 'should create a hash' do
        hash = subject.to_hash(child_entity)
        expect(hash[:text]).to eq(child_entity.text)
        expect(hash[:numeric]).to eq(child_entity.numeric)
        expect(hash[:time]).to eq(child_entity.time)
      end
    end

    context 'multi layer entity' do
     it 'should create a hash' do
       hash = subject.to_hash(parent_entity)
       expect(hash[:text]).to eq(parent_entity.text)
       expect(hash[:numeric]).to eq(parent_entity.numeric)
       expect(hash[:time]).to eq(parent_entity.time)
       expect(hash[:hash].has_key?(:key1)).to be true
       expect(hash[:hash_array].length).to eq(2)
       expect(hash[:entity][:text]).to eq(child_entity.text)
       expect(hash[:entity][:numeric]).to eq(child_entity.numeric)
       expect(hash[:entity][:time]).to eq(child_entity.time)
       expect(hash[:entity_array].length).to eq(2)
       expect(hash[:entity_array][0][:text]).to eq(child_entity.text)
       expect(hash[:entity_array][1][:text]).to eq(child_entity.text)
     end
    end

  end
end