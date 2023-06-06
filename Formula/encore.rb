class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.20.3"
    checksums = {
        "darwin_arm64" => "b39dd96249c781e802c0cd0a9ff37497191cc85fbd96f40b66d50a13b333eab6",
        "darwin_amd64" => "bba01bf6f29470f58460ac57109a19d56399b624a157e4c28b30b3f1b2cec9d5",
        "linux_arm64"  => "39fe47ccde90395d51936a3c2585c68aada31c9b9b3eea0f7f4026b15134a72d",
        "linux_amd64"  => "cfeb1861f15f298cf3648f606ff2a7338ef4a33d6f76f45e317c921fb2247fda",
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
