class Encore < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "1.41.13"
    checksums = {
        "darwin_arm64" => "00d9ec6823cc83df72f845362622605d3230fbcc5c0a166eb72621aef4215167",
        "darwin_amd64" => "681ad00594be63bf3d46882f29bc40ffc5ffa04ec42782098fc410b33508e7a9",
        "linux_arm64"  => "60ddbaab7484c161e4443f918930092a09a3a5c12d4628c6389b83f273b5ec77",
        "linux_amd64"  => "75d1bb7d651d4689cd4fe713ad97d9233f5a6712b03afd16bc219427c9017848",
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
