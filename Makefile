STLDIR=stl
DEPDIR=.deps
DIRS=$(DEPDIR) $(STLDIR)
SOURCES=$(file < SOURCES.txt)
CLEANOBJS=$(DEPDIR) $(STLDIR)

all: $(patsubst %,$(STLDIR)/%.stl,$(SOURCES)) | $(DIRS)

$(STLDIR)/%.stl: %.scad | $(DIRS)
	openscad -o $@ $< -d $(DEPDIR)/$*.d

clean:
	rm -rf $(CLEANOBJS)

$(DIRS): 
	mkdir -p $(DIRS)

include $(wildcard $(DEPDIR)/*.d)

