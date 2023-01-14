class EncoreNightly < Formula
    desc "The static analysis-powered Go framework for building backend applications"
    homepage "https://encore.dev"
    license "Mozilla Public License, version 2.0"
    head "https://github.com/encoredev/encore.git", branch: "main"

    release_version = "nightly-20230114"
    checksums = {
        "darwin_arm64" => "595a44dbfc1b9001f82f98fa38ca10a508982215c074c501de8f54e0fb55af51",
        "darwin_amd64" => "9e3730830d80ce448f4e7fb792ef7e4439eba05373484cc07e7f260e7d5dd7a0",
        "linux_arm64"  => "d610dc35b8d2d7521d619e435a2a7defc946c95550a4b838860376487b58e3af",
        "linux_amd64"  => "eceff3234ecdf3531f2574972a2484dfe6693220d8dc41a6e787feb32649daa2",
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
