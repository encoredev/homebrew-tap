class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230723"
    checksums = {
        "darwin_arm64" => "f7e32419f52954a8b68f9e03c5f47743748ebdb528d698fd3e99a883c9fbb9b3",
        "darwin_amd64" => "7950a805057f5935cc5bbe80a871e80e9a552f242efb4601124132e0368ab93e",
        "linux_arm64"  => "cb667d132b5d569380f911b3dedbbcf73ff2a95b241558dfd35ef12d3b25171e",
        "linux_amd64"  => "d7cf1a7156ec33a12623cde6577a1ff77e5c581885b8206df34788580be9e930",
    }

    arch = "arm64"
    platform = "darwin"
    on_intel do
        arch = "amd64"
    end
    on_linux do
        platform = "linux"
    end

    url "https://d2f391esomvqpi.cloudfront.net/encore-#{release_version}-#{platform}_#{arch}.tar.gz"
    version release_version
    sha256 checksums["#{platform}_#{arch}"]

    def install
        libexec.install Dir["*"]
        bin.install_symlink Dir[libexec/"bin/*"]

        # Install bash completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "bash")
        (bash_completion/"encore").write output

        # Install zsh completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "zsh")
        (zsh_completion/"_encore").write output

        # Install fish completion
        output = Utils.safe_popen_read(bin/"encore", "completion", "fish")
        (fish_completion/"encore.fish").write output
    end

    test do
        system "#{bin}/encore", "check"
    end
end
