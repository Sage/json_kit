require 'spec_helper'

RSpec.describe JsonKit::Helper do
  describe '#to_json' do

    let(:hash) do
      { key1: 'value1' }
    end

    let(:class_instance) do
      TestEntity.new.tap do |entity|
        entity.text = 'abc'
        entity.numeric = 5
      end
    end

    context 'Hash' do
      it 'should create a json string' do
        json = subject.to_json(hash)
        expect(json).to eq('{"key1":"value1"}')
      end
    end

    context 'String' do
      it 'should return the string and not json serialize it' do
        string = 'abc'
        value = subject.to_json(string)
        expect(value).to eq(string)
      end
    end

    context 'Class Instance' do
      it 'should create a json string' do
        json = subject.to_json(class_instance)
        expect(json).to eq('{"text":"abc","numeric":5}')
      end
    end

  end

  describe '#from_json' do
    let(:json) do
      '{"text":"abc","numeric":5}'
    end

    context 'when no klass is specified' do

      it 'should return a hash form the json' do
        expect(subject.from_json(json)).to eq({ text: 'abc', numeric: 5 })
      end

    end

    context 'when a klass is specified' do
      it 'should return an instance of the class populated by the json' do
        obj = subject.from_json(json, TestEntity)
        expect(obj).to be_a(TestEntity)
        expect(obj.text).to eq('abc')
        expect(obj.numeric).to eq(5)
      end
    end

  end

end