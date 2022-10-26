class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20221026"
    checksums = {
        "darwin_arm64" => "57f135c607758913af5815357703ff7e011a91631684b7e65c37eb59035502fc",
        "darwin_amd64" => "ec886162242f2d12e52228bbaba3ffa41972117979f9cfc400efd9a26873558e",
        "linux_arm64"  => "f36eabb821c0c36b5f786f109b5bb8c35d549cc23a0fa2852a7e082646acc293",
        "linux_amd64"  => "5a42bd76a78b6ea84a2113d89484bdb89a03e05946a5591e94f5a00e993ce907",
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
