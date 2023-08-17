class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230817"
    checksums = {
        "darwin_arm64" => "165bea2dd573a6564fa06f3a9c6117f3e1f3f568541dca88fdafb99274dd3b57",
        "darwin_amd64" => "17bcd28e4bb6bca5e956f2cff162d9579db37c8ef853cb038320faaee1f93dc1",
        "linux_arm64"  => "8833faf3123b4ca85386720f9a140851825836cf4814a62d06531d2075917773",
        "linux_amd64"  => "b5b821875941b110c4bdbfedcb107b66062f57d89691571af56ea3fa0aa68338",
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
